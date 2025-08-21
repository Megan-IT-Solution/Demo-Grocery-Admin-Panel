import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:grocery_admin_panel/screens/auth/widgets/auth_footer.dart';
import 'package:provider/provider.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../controllers/loading_controller.dart';
import '../../services/auth_services.dart';
import '../../widgets/buttons.dart';
import '../../widgets/text_inputs.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static TextEditingController usernameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
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
                    Text(
                      AppStrings.signUpToStartYourSession,
                      style: AppTextStyles.nunitoSemiBod.copyWith(
                        fontSize: 22.sp,
                        color: AppColors.primaryBlack.withValues(alpha: 0.5),
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomTextInput(
                      hintText: AppStrings.userName,
                      suffixIcon: AppAssets.person,
                      controller: usernameController,
                    ),
                    const SizedBox(height: 15),
                    CustomTextInput(
                      hintText: AppStrings.email,
                      suffixIcon: AppAssets.mail,
                      controller: emailController,
                    ),
                    const SizedBox(height: 15),
                    CustomTextInput(
                      hintText: AppStrings.password,
                      suffixIcon: AppAssets.lock,
                      controller: passwordController,
                    ),
                    SizedBox(height: 52.h),
                    loadingController.isLoading
                        ? const CircularProgressIndicator()
                        : PrimaryButton(
                          title: AppStrings.signUp,
                          width: Get.width,
                          height: 110.h,
                          onTap: () async {
                            await AuthServices.signUp(
                              username: usernameController.text,
                              context: context,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          },
                        ),
                    SizedBox(height: 20.h),
                    AuthFooter(
                      title: "Already have an account? ",
                      pageName: "Sign in",
                      onTap: () {
                        Get.offAllNamed('/');
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
