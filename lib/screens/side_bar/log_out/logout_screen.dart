import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../services/auth_services.dart';
import '../../../widgets/buttons.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 689.w,
            padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 50.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.primaryWhite,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 93.h,
                  width: 93.w,
                  child: Image.asset(AppAssets.logoutIcon),
                ),
                SizedBox(height: 21.h),
                Text(
                  AppStrings.logout,
                  style: AppTextStyles.nunitoBold.copyWith(fontSize: 30.sp),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Are you absolutely certain you wish to \nproceed with logging out?",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.nunitoSemiBod.copyWith(fontSize: 22.sp),
                ),
                SizedBox(height: 43.h),
                PrimaryButton(
                  title: "Yes, Logout",
                  onTap: () async {
                    await AuthServices.logOut();
                  },
                  width: 264.w,
                  height: 80.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
