import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../controllers/loading_controller.dart';
import '../../widgets/buttons.dart';
import 'login_screen.dart';

class PasswordResetLinkScreen extends StatelessWidget {
  const PasswordResetLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loadingController = Provider.of<LoadingController>(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                AppStrings.appName,
                style: AppTextStyles.nunitoBold.copyWith(
                  fontSize: 52.sp,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 689.w,
                padding: EdgeInsets.symmetric(horizontal: 77.w, vertical: 55.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      "Password reset link has been send to your email. Please check your email inbox and confirm.",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.quicksandMedium.copyWith(
                        fontSize: 19,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 80),
                    PrimaryButton(
                      title: "Done",
                      height: 70.h,
                      width: 200.w,
                      onTap: () {
                        Get.offAll(() => LoginScreen());
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
