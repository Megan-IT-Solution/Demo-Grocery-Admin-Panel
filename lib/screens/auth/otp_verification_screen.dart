import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../widgets/buttons.dart';
import '../../widgets/text_inputs.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({
    super.key,
    required this.email,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String otp = '';
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
                padding: EdgeInsets.symmetric(horizontal: 77.w, vertical: 55.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Text(
                      AppStrings.verification,
                      style: AppTextStyles.nunitoBold.copyWith(
                          fontSize: 28.sp, color: AppColors.primaryColor),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppStrings.pleaseProvideValidVerificationCode,
                      style: AppTextStyles.nunitoSemiBod.copyWith(
                          fontSize: 22.sp,
                          color: AppColors.primaryBlack.withOpacity(0.5)),
                    ),
                    const SizedBox(height: 43),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OtpTextField(
                          onChanged: (v) {
                            if (v.length == 1) {
                              FocusScope.of(context).nextFocus();
                              otp = otp + v;
                            }
                          },
                        ),
                        const SizedBox(width: 30),
                        OtpTextField(
                          onChanged: (v) {
                            if (v.length == 1) {
                              FocusScope.of(context).nextFocus();

                              otp = otp + v;
                            }
                          },
                        ),
                        const SizedBox(width: 30),
                        OtpTextField(
                          onChanged: (v) {
                            if (v.length == 1) {
                              FocusScope.of(context).nextFocus();

                              otp = otp + v;
                            }
                          },
                        ),
                        const SizedBox(width: 30),
                        OtpTextField(
                          onChanged: (v) {
                            if (v.length == 1) {
                              FocusScope.of(context).nextFocus();

                              otp = otp + v;
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 78),
                    Text(
                      "${AppStrings.didNotReceiveCode}?",
                      style:
                          AppTextStyles.nunitoSemiBod.copyWith(fontSize: 16.sp),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      AppStrings.resend,
                      style: AppTextStyles.nunitoBold.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryColor),
                    ),
                    const SizedBox(height: 42),
                    PrimaryButton(
                      title: AppStrings.sendOtp,
                      width: 264.w,
                      height: 110.h,
                      onTap: () async {},
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
