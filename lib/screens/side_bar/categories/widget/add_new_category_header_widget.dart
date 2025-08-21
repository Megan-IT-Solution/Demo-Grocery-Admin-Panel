import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_strings.dart';
import '../../../../constants/app_text_styles.dart';

class AddNewCategoryHeaderWidget extends StatelessWidget {
  const AddNewCategoryHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90.h,
      padding: EdgeInsets.symmetric(horizontal: 29.w),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          AppStrings.addNewCategory,
          style: AppTextStyles.nunitoBold.copyWith(
            fontSize: 24.sp,
            color: AppColors.primaryWhite,
          ),
        ),
      ),
    );
  }
}
