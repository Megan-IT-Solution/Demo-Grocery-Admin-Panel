import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_text_styles.dart';

TableRow tableHeader(List dataColumn) {
  return TableRow(
    children:
        dataColumn
            .map(
              (e) => Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      e,
                      style: AppTextStyles.nunitoBold.copyWith(fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
  );
}
