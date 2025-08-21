import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_text_styles.dart';

Widget tableHeaderWidget(String text) {
  return Padding(
    padding: EdgeInsets.all(10.w),
    child: Center(
      child: Text(
        text,
        style: AppTextStyles.nunitoBold.copyWith(
          fontSize: 15.sp,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
