import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

import '../constants/app_strings.dart';
import '../constants/custom_msgs.dart';
import '../constants/database_constants.dart';
import '../controllers/loading_controller.dart';
import '../models/admin_model.dart';
import '../models/rider_model.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/password_reset_link_screen.dart';

class AuthServices {
  static signUp({
    required String username,
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (username.isEmpty) {
      showCustomMsg(context, AppStrings.nameReq);
    } else if (email.isEmpty) {
      showCustomMsg(context, AppStrings.emailReq);
    } else if (password.isEmpty) {
      showCustomMsg(context, AppStrings.password);
    } else {
      try {
        Provider.of<LoadingController>(context, listen: false).setLoading(true);
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        AdminModel adminModel = AdminModel(
          image: "",
          email: email,
          id: auth.currentUser!.uid,
          username: username,
        );
        await firestore
            .collection("admins")
            .doc(auth.currentUser!.uid)
            .set(adminModel.toMap());
        Get.offAllNamed('/');

        if (!context.mounted) return;
        Provider.of<LoadingController>(
          context,
          listen: false,
        ).setLoading(false);
      } on FirebaseAuthException catch (e) {
        Provider.of<LoadingController>(
          context,
          listen: false,
        ).setLoading(false);

        showCustomMsg(context, e.message.toString());
      }
    }
  }

  static Future<void> loginAdmin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (email.isEmpty) {
      showCustomMsg(context, AppStrings.emailReq);
      return;
    } else if (password.isEmpty) {
      showCustomMsg(context, AppStrings.passwordReq);
      return;
    }

    try {
      Provider.of<LoadingController>(context, listen: false).setLoading(true);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!context.mounted) return;
      Provider.of<LoadingController>(context, listen: false).setLoading(false);
      Get.offAllNamed('/sideBarScreen');
    } on FirebaseAuthException catch (e) {
      Provider.of<LoadingController>(context, listen: false).setLoading(false);

      showCustomMsg(context, e.message.toString());
    }
  }

  static forgotPassword({
    required BuildContext context,
    required String email,
  }) async {
    if (email.isEmpty) {
      showCustomMsg(context, AppStrings.emailReq);
    } else {
      try {
        Provider.of<LoadingController>(context, listen: false).setLoading(true);
        await auth.sendPasswordResetEmail(email: email);

        if (!context.mounted) return;
        Provider.of<LoadingController>(
          context,
          listen: false,
        ).setLoading(false);
        Get.to(() => const PasswordResetLinkScreen());
      } on FirebaseAuthException catch (e) {
        Provider.of<LoadingController>(
          context,
          listen: false,
        ).setLoading(false);

        showCustomMsg(context, e.message.toString());
      }
    }
  }

  static logOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => const LoginScreen());
  }

  Future<void> deleteRider(RiderModel riderModel, BuildContext context) async {
    try {
      bool confirmDelete = await showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Confirm Delete'),
              content: Text(
                'Are you sure you want to delete ${riderModel.riderName}?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
      );

      if (confirmDelete == true) {
        await FirebaseFirestore.instance
            .collection('riders')
            .doc(riderModel.userId)
            .delete();

        if (!context.mounted) return;
        showCustomMsg(context, 'Deleted Successfully');
      }
    } catch (e) {
      if (!context.mounted) return;
      showCustomMsg(context, e.toString());
    }
  }

  Future<void> approveRider(RiderModel riderModel, BuildContext context) async {
    try {
      bool confirmApprove = await showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Confirm Approve'),
              content: Text(
                'Are you sure you want to approve ${riderModel.riderName}?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Yes', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
      );

      if (confirmApprove == true) {
        await FirebaseFirestore.instance
            .collection('riders')
            .doc(riderModel.userId)
            .update({'isAccountApproved': "approved"});

        if (!context.mounted) return;
        showCustomMsg(context, 'Approved Successfully');
      }
    } catch (e) {
      if (!context.mounted) return;
      showCustomMsg(context, e.toString());
    }
  }
}
