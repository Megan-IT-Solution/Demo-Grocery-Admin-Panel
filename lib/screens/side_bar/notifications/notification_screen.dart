import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool currentPassword = true;
  bool newPassword = true;
  bool confirmNewPassword = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45.w, vertical: 36.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notifications",
              style: AppTextStyles.nunitoBold.copyWith(
                fontSize: 45.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 66.h),
            Container(
              width: 1100.w,
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 55.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.primaryWhite,
              ),
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance
                        .collection('notifications')
                        .where(
                          'toUserId',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                        )
                        .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No Notification Found!"));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.notifications),
                            title: Text(
                              snapshot.data!.docs[index]['title'],
                              style: AppTextStyles.quicksandBold.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              snapshot.data!.docs[index]['body'],

                              style: AppTextStyles.quicksandMedium.copyWith(
                                fontSize: 12,
                              ),
                            ),
                            trailing: Text(
                              DateFormat('dd MMMM yyy hh:mm a').format(
                                snapshot.data!.docs[index]['createdAt']
                                    .toDate(),
                              ),
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          Divider(),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
