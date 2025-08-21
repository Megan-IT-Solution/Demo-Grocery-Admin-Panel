import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_text_styles.dart';

Widget tableCellWidgetOrderScreen(
  String text, {
  bool? isBold,
  Color? textColor,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
    child: Center(
      child: Text(
        text,
        style: AppTextStyles.nunitoMedium.copyWith(
          fontSize: 16.sp,
          fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
          color: textColor ?? AppColors.primaryBlack,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
