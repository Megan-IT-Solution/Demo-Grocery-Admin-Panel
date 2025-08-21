import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/text_inputs.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  bool currentPassword = true;
  bool newPassword = true;
  bool confirmNewPassword = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45.w, vertical: 36.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Profile Setting",
              style: AppTextStyles.nunitoBold.copyWith(
                fontSize: 45.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 66.h),
            Center(
              child: Container(
                width: 904.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 202.w,
                  vertical: 55.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primaryWhite,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 140.w,
                          height: 140.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(AppAssets.profileImage),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 12.w,
                          bottom: 10.h,
                          child: Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryWhite,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x190013CE),
                                  blurRadius: 4,
                                  offset: Offset(0, 0),
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Image.asset(
                                AppAssets.edit,
                                height: 24.h,
                                width: 24.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 29.h),
                    ProfileTextInput(
                      labelText: "Username",
                      controller: TextEditingController(text: "Andrew Rapchat"),
                    ),
                    SizedBox(height: 29.h),
                    ProfileTextInput(
                      labelText: "Email",
                      controller: TextEditingController(
                        text: "example12@gmail.com",
                      ),
                    ),
                    SizedBox(height: 29.h),
                    ProfileTextInput(
                      isPassword: currentPassword,
                      labelText: "Current Password",
                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            currentPassword = !currentPassword;
                          });
                        },
                        icon: Icon(
                          size: 24.sp,
                          currentPassword
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      controller: TextEditingController(text: "yRzjaHTjxIE4"),
                    ),
                    SizedBox(height: 29.h),
                    ProfileTextInput(
                      isPassword: newPassword,
                      labelText: "New Password",
                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            newPassword = !newPassword;
                          });
                        },
                        icon: Icon(
                          size: 24.sp,
                          newPassword
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      controller: TextEditingController(text: "yRzjaHTjxIE4"),
                    ),
                    SizedBox(height: 29.h),
                    ProfileTextInput(
                      isPassword: confirmNewPassword,
                      labelText: "Confirm New Password",
                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            confirmNewPassword = !confirmNewPassword;
                          });
                        },
                        icon: Icon(
                          size: 24.sp,
                          confirmNewPassword
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      controller: TextEditingController(text: "yRzjaHTjxIE4"),
                    ),
                    SizedBox(height: 50.h),
                    PrimaryButton(
                      title: "Save Changes",
                      width: 384.w,
                      height: 110.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
