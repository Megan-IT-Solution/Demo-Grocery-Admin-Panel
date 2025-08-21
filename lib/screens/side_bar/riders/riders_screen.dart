import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../models/rider_model.dart';
import '../../../services/auth_services.dart';
import '../../../widgets/text_inputs.dart';
import '../widgets/padded_text_widget.dart';
import '../widgets/table_header_widget.dart';

class RidersScreen extends StatefulWidget {
  const RidersScreen({super.key});

  @override
  State<RidersScreen> createState() => _RidersScreenState();
}

class _RidersScreenState extends State<RidersScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Riders",
            style: AppTextStyles.nunitoBold.copyWith(
              fontSize: 40.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            width: double.infinity,
            height: 120.h,
            padding: const EdgeInsets.symmetric(horizontal: 19),
            decoration: BoxDecoration(
              color: AppColors.primaryWhite,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Text(
                  "${AppStrings.search}:",
                  style: AppTextStyles.nunitoBold.copyWith(fontSize: 22.sp),
                ),
                SizedBox(width: 22.w),
                SearchTextInput(),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('riders').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 200),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 270),
                        child: Text(
                          "No Rider Found!",
                          style: AppTextStyles.nunitoBold,
                        ),
                      ),
                    );
                  }

                  return Table(
                    defaultColumnWidth: FixedColumnWidth(180.w),
                    border: TableBorder.all(color: const Color(0x33474747)),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                        ),
                        children: [
                          tableHeaderWidget("Name"),
                          tableHeaderWidget("Phone Number"),
                          tableHeaderWidget("Joining Date"),
                          tableHeaderWidget("Email"),
                          tableHeaderWidget("Status"),
                          tableHeaderWidget("Actions"),
                        ],
                      ),
                      ...snapshot.data!.docs.map((rider) {
                        RiderModel riderModel = RiderModel.fromMap(rider);
                        return TableRow(
                          children: [
                            paddedTextWidget(riderModel.riderName),
                            paddedTextWidget(riderModel.phoneNumber.toString()),
                            paddedTextWidget(
                              DateFormat(
                                "dd MMMM yyyy",
                              ).format(riderModel.memberSince),
                            ),
                            paddedTextWidget(riderModel.email),
                            paddedTextWidget(riderModel.isAccountApproved),
                            Padding(
                              padding: EdgeInsets.all(10.w),
                              child: Center(
                                child: PopupMenuButton<String>(
                                  icon: const Icon(Icons.more_vert),
                                  onSelected: (value) async {
                                    if (value == 'delete') {
                                      await AuthServices().deleteRider(
                                        riderModel,
                                        context,
                                      );
                                    }
                                    if (value == 'approved') {
                                      await AuthServices().approveRider(
                                        riderModel,
                                        context,
                                      );
                                    }
                                  },
                                  itemBuilder:
                                      (context) => [
                                        const PopupMenuItem(
                                          value: 'approved',
                                          child: Text('Approved'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'delete',
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
