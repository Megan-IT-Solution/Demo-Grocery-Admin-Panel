import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';

class AuthFooter extends StatelessWidget {
  final String title;
  final String pageName;
  final VoidCallback onTap;
  const AuthFooter({
    super.key,
    required this.title,
    required this.pageName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyles.nunitoRegular.copyWith(fontSize: 15.sp),
          ),
          SizedBox(width: 2.w),
          Text(
            pageName,
            style: AppTextStyles.nunitoSemiBod.copyWith(
              color: AppColors.primaryColor,
              fontSize: 17.sp,
            ),
          ),
        ],
      ),
    );
  }
}
