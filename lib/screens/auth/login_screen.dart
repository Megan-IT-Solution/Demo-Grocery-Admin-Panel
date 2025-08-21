import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                      AppStrings.signInToStartYourSession,
                      style: AppTextStyles.nunitoSemiBod.copyWith(
                        fontSize: 22.sp,
                        color: AppColors.primaryBlack.withValues(alpha: 0.5),
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextInput(
                      hintText: AppStrings.email,
                      suffixIcon: AppAssets.mail,
                      controller: emailController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextInput(
                      hintText: AppStrings.password,
                      suffixIcon: AppAssets.lock,
                      isPassword: true,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.offAllNamed('/forgotPassword');
                        },
                        child: Text(
                          "${AppStrings.forgotPassword}?",
                          style: GoogleFonts.dmSans(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    loadingController.isLoading
                        ? const CircularProgressIndicator()
                        : PrimaryButton(
                          title: AppStrings.signIn,
                          width: Get.width,
                          height: 110.h,
                          onTap: () async {
                            await AuthServices.loginAdmin(
                              context: context,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            emailController.clear();
                            passwordController.clear();
                          },
                        ),
                    SizedBox(height: 20.h),
                    AuthFooter(
                      title: "Don't have an account? ",
                      pageName: "SignUp",
                      onTap: () {
                        Get.offAllNamed('/signUp');
                        // Get.to(const SignUpScreen());
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
