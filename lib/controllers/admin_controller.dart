import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/admin_model.dart';

class AdminController extends ChangeNotifier {
  AdminModel? _adminModel;
  Stream<DocumentSnapshot>? _userStream;

  AdminModel? get admin => _adminModel;

  getAdminInformation() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    _userStream =
        FirebaseFirestore.instance
            .collection('admins')
            .doc(currentUser.uid)
            .snapshots();

    _userStream!.listen((doc) {
      if (doc.exists && doc.data() != null) {
        _adminModel = AdminModel.fromDoc(doc);
        notifyListeners();
      }
    });
  }

  void stopListening() {
    _userStream = null;
  }
}
