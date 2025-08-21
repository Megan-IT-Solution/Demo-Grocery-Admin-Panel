import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback? onTapOk;
  final VoidCallback? onTapCancel;
  const CustomAlertDialog({
    super.key,
    required this.content,
    this.title = "stonestreet.appistaan.com says",
    this.onTapOk,
    this.onTapCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: AppTextStyles.nunitoMedium.copyWith(fontSize: 20.sp),
      ),
      content: Text(
        content,
        style: AppTextStyles.nunitoMedium.copyWith(fontSize: 20.sp),
      ),
      actions: [
        GestureDetector(
          onTap: onTapOk,
          child: Container(
            width: 110.w,
            height: 50.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: const Color(0xFF008EDE))),
            child: Container(
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xFF008EDE),
              ),
              child: Center(
                child: Text(
                  AppStrings.ok,
                  style: GoogleFonts.dmSans(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryWhite),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: onTapCancel,
          child: Container(
            width: 110.w,
            height: 50.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    width: 1, color: AppColors.primaryBlack.withOpacity(0.3))),
            child: Center(
              child: Text(
                AppStrings.cancel,
                style: GoogleFonts.dmSans(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF008EDE)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
