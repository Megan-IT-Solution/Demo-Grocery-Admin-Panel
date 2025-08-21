import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';

class BottomRowForShowEntries extends StatelessWidget {
  final int? totalPages;
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final String? hint;
  final int? currentPageNo;
  final int? currentIndex;
  const BottomRowForShowEntries({
    super.key,
    this.totalPages,
    this.onNext,
    this.onBack,
    this.hint,
    this.currentPageNo,
    this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          hint!,
          style: AppTextStyles.nunitoBold.copyWith(fontSize: 16.sp),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: onBack,
              child: Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPageNo! != 0
                        ? AppColors.primaryColor
                        : Colors.grey),
                child: Center(
                  child: Icon(
                    Icons.navigate_before_rounded,
                    size: 25.sp,
                    color: AppColors.primaryWhite,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ...List.generate(
                totalPages!,
                (index) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        "${index + 1}",
                        style: GoogleFonts.dmSans(
                            fontSize: 14.sp,
                            color: index == currentIndex
                                ? AppColors.primaryColor
                                : const Color(0xFFAFAFAF),
                            fontWeight: index == currentIndex
                                ? FontWeight.w600
                                : FontWeight.w400),
                      ),
                    )),
            // Container(
            //   height: 40.h,
            //   width: 40.w,
            //   decoration: const BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: Color(0xFFDEDCDC),
            //   ),
            //   child: Center(
            //     child: Icon(
            //       Icons.more_horiz,
            //       size: 25.sp,
            //       color: AppColors.primaryBlack,
            //     ),
            //   ),
            // ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: onNext,
              child: Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPageNo! < totalPages!
                        ? AppColors.primaryColor
                        : Colors.grey),
                child: Center(
                  child: Icon(
                    Icons.navigate_next,
                    size: 25.sp,
                    color: AppColors.primaryWhite,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
