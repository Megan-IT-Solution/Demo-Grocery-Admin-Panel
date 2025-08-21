import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../services/auth_services.dart';
import '../../widgets/buttons.dart';
import '../../widgets/text_inputs.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  static TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                width: 689.w,
                padding: const EdgeInsets.symmetric(
                  horizontal: 77,
                  vertical: 55,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.offAllNamed('/');
                          },

                          child: Icon(Icons.arrow_back),
                        ),
                        SizedBox(width: 80),
                        Text(
                          AppStrings.forgotPassword,
                          style: AppTextStyles.nunitoBold.copyWith(
                            fontSize: 28.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppStrings.enterYourValidEmailAddress,
                      style: AppTextStyles.nunitoSemiBod.copyWith(
                        fontSize: 22.sp,
                        color: AppColors.primaryBlack.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 60),
                    CustomTextInput(
                      hintText: AppStrings.email,
                      suffixIcon: AppAssets.mail,
                      controller: emailController,
                    ),
                    const SizedBox(height: 78),
                    PrimaryButton(
                      title: AppStrings.verify,
                      width: 264.w,
                      height: 110.h,
                      onTap: () async {
                        await AuthServices.forgotPassword(
                          context: context,
                          email: emailController.text,
                        );
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
