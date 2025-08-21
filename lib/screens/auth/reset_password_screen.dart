import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../widgets/buttons.dart';
import '../../widgets/text_inputs.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Container(
                width: 689.w,
                padding: EdgeInsets.symmetric(horizontal: 77.w, vertical: 55.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Text(
                      AppStrings.resetPassword,
                      style: AppTextStyles.nunitoBold.copyWith(
                          fontSize: 28.sp, color: AppColors.primaryColor),
                    ),
                    SizedBox(height: 12),
                    Text(
                      AppStrings.initiatePassword,
                      style: AppTextStyles.nunitoSemiBod.copyWith(
                          fontSize: 22.sp,
                          color: AppColors.primaryBlack.withOpacity(0.5)),
                    ),
                    const SizedBox(height: 43),
                    const CustomTextInput(
                      hintText: AppStrings.newPassword,
                      suffixIcon: AppAssets.lock,
                    ),
                    SizedBox(height: 40.h),
                    const CustomTextInput(
                      hintText: AppStrings.confirmNewPassword,
                      suffixIcon: AppAssets.lock,
                    ),
                    const SizedBox(
                      height: 65,
                    ),
                    PrimaryButton(
                      title: AppStrings.resetPassword,
                      width: 264.w,
                      height: 110.h,
                      onTap: () {
                        Get.offAll(() => const LoginScreen());
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
