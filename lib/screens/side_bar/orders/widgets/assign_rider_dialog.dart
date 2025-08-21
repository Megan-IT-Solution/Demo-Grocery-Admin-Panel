import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../controllers/loading_controller.dart';
import '../../../../services/notification_services.dart';
import '../../../../services/order_services.dart';
import '../../../../widgets/buttons.dart';

class AssignRiderDialog extends StatefulWidget {
  final String orderId;
  final String userId;
  const AssignRiderDialog({
    super.key,
    required this.orderId,
    required this.userId,
  });

  @override
  State<AssignRiderDialog> createState() => _AssignRiderDialogState();
}

class _AssignRiderDialogState extends State<AssignRiderDialog> {
  String? selectedRider;
  String? riderId;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: Get.width * 0.6,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assign Rider to this Order',
                style: AppTextStyles.h1.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30.h),
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('riders').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No Rider Found"));
                  }
                  return DropdownButton<String>(
                    value: selectedRider,
                    isExpanded: true,
                    hint: const Text("Select a rider from the list"),
                    items:
                        snapshot.data!.docs.map((rider) {
                          return DropdownMenuItem<String>(
                            value: rider['username'],
                            child: Text(rider['username']),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRider = value;
                        final docs = snapshot.data!.docs;
                        final matchingDoc =
                            docs.any((doc) => doc['username'] == value)
                                ? docs.firstWhere(
                                  (doc) => doc['username'] == value,
                                )
                                : null;

                        if (matchingDoc != null) {
                          riderId = matchingDoc.id;
                        }
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 60.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SecondaryButton(
                    onPressed: () {
                      Get.back();
                    },
                    title: "Cancel",
                    btnColor: AppColors.primaryWarning,
                  ),
                  SizedBox(width: 40.w),

                  Consumer<LoadingController>(
                    builder: (context, loadingController, child) {
                      return loadingController.isLoading
                          ? SizedBox(
                            height: 60,
                            child: CircularProgressIndicator(),
                          )
                          : SecondaryButton(
                            onPressed: () async {
                              Get.back();

                              await OrderServices().assignOrderToRider(
                                context: context,
                                riderId: riderId!,
                                orderId: widget.orderId,
                              );
                              await NotificationServices()
                                  .sendNotificationToSpecificUser(
                                    title: "Order Updates",
                                    body: "Your Order is Assigned to the Rider",
                                    toUserId: widget.userId,
                                  );

                              await NotificationServices.saveNotification(
                                orderId: widget.orderId,
                                toUserId: widget.userId,
                                title: "Order Updates",
                                body: "Your Order is Assigned to the Rider",
                                notificationType: "Order",
                              );
                            },
                            title: "Assign",
                            btnColor: AppColors.primaryColor,
                          );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
