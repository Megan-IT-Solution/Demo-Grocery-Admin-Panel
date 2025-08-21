import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_text_styles.dart';

TableRow tableHeaderWidgetOrderScreen(List<String> headers) {
  return TableRow(
    decoration: BoxDecoration(color: AppColors.primaryColor),
    children:
        headers
            .map(
              (text) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                child: Center(
                  child: Text(
                    text,
                    style: AppTextStyles.nunitoBold.copyWith(
                      fontSize: 15.sp,
                      color: AppColors.primaryWhite,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
            .toList(),
  );
}
