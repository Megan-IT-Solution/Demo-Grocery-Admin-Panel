import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_text_styles.dart';

Widget paddedTextWidget(String? text) {
  return Padding(
    padding: EdgeInsets.all(10.w),
    child: Text(
      text ?? '',
      style: AppTextStyles.nunitoMedium.copyWith(fontSize: 16.sp),
      textAlign: TextAlign.center,
    ),
  );
}
