import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';

class DashboardCustomTile extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final String subTitle;
  final String icon;
  final Color backgroundColor;
  final Color bottomColor;
  const DashboardCustomTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.backgroundColor,
    required this.bottomColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 240.h,
        width: 400.w,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
              child: Row(
                children: [
                  SizedBox(
                    height: 70.h,
                    width: 70.w,
                    child: Image.asset(
                      icon,
                      color: AppColors.primaryWhite,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Spacer(),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.nunitoBold.copyWith(
                          fontSize: 30.sp,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        subTitle,
                        style: AppTextStyles.nunitoBold.copyWith(
                          fontSize: 24.sp,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Container(
            //   width: 313.w,
            //   height: 31.h,
            //   decoration: BoxDecoration(
            //     color: bottomColor,
            //     borderRadius: const BorderRadius.vertical(
            //       bottom: Radius.circular(5),
            //     ),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         AppStrings.moreInfo,
            //         style: AppTextStyles.nunitoBold.copyWith(
            //           fontSize: 13.sp,
            //           color: AppColors.primaryWhite,
            //         ),
            //       ),
            //       SizedBox(width: 5.w),
            //       Icon(
            //         Icons.arrow_circle_right,
            //         size: 18.sp,
            //         color: AppColors.primaryWhite,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
