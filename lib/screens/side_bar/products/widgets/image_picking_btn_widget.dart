import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_strings.dart';
import '../../../../constants/app_text_styles.dart';

class ImagePickingBtnWidget extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  const ImagePickingBtnWidget({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.primaryBlack),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 220.w,
              decoration: BoxDecoration(
                color: const Color(0x70757575),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Center(
                child: Text(
                  AppStrings.chooseFile,
                  style: AppTextStyles.nunitoMedium.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            title,
            style: AppTextStyles.nunitoMedium.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
