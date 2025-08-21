import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final Color btnColor;
  const PrimaryButton({
    super.key,
    this.width,
    this.height,
    this.onTap,
    this.btnColor = AppColors.primaryBlack,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 64,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.nunitoBold.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryWhite,
            ),
          ),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String title;
  final Color btnColor;
  final double? width, fontSize;
  final Function()? onPressed;
  const SecondaryButton({
    super.key,
    required this.title,
    required this.btnColor,
    this.onPressed,
    this.width,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 45,
        width: width ?? Get.width * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: btnColor,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.primaryWhite,
              fontWeight: FontWeight.bold,
              fontSize: fontSize ?? 16,
            ),
          ),
        ),
      ),
    );
  }
}
