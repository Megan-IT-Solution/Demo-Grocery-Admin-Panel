import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class CustomTextInput extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final String? suffixIcon;
  final bool isPassword;
  final Widget? suffixWidget;
  const CustomTextInput({
    super.key,
    this.hintText,
    this.controller,
    this.inputType,
    this.suffixIcon,
    this.isPassword = false,
    this.suffixWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: inputType ?? TextInputType.text,
        style: const TextStyle(),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.only(left: 10.w),
          hintStyle: AppTextStyles.nunitoMedium.copyWith(
            fontSize: 18.sp,
            color: AppColors.primaryBlack.withValues(alpha: 0.5),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                suffixIcon == null
                    ? suffixWidget
                    : Image.asset(suffixIcon!, height: 28, width: 28),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: AppColors.primaryBlack.withValues(alpha: 0.5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}

class OtpTextField extends StatelessWidget {
  final Function(String v)? onChanged;

  const OtpTextField({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        style: AppTextStyles.quicksandSemiBold.copyWith(
          color: AppColors.primaryBlack.withValues(alpha: 0.5),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(
              color: AppColors.primaryBlack.withValues(alpha: 0.5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
    );
  }
}

class CategoryTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  const CategoryTextField({
    super.key,
    this.hintText,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType ?? TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.nunitoSemiBod.copyWith(
          fontSize: 20.sp,
          color: AppColors.primaryBlack.withValues(alpha: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryBlack),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class ProfileTextInput extends StatelessWidget {
  final String? labelText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool isPassword;
  const ProfileTextInput({
    super.key,
    this.labelText,
    this.controller,
    this.suffixIcon,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.h,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xCCC7C8C8)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: SizedBox(
          height: 90.h,
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            obscuringCharacter: "X",
            style: AppTextStyles.nunitoRegular.copyWith(
              fontSize: 14.sp,
              color: AppColors.primaryBlack,
            ),
            decoration: InputDecoration(
              label: Text(
                labelText!,
                style: AppTextStyles.nunitoRegular.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.primaryBlack.withValues(alpha: 0.5),
                ),
              ),
              suffixIcon: suffixIcon,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchTextInput extends StatelessWidget {
  final Function(String? v)? onChanged;
  const SearchTextInput({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 292.w,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, top: 10),
        child: TextField(
          onChanged: onChanged,
          style: TextStyle(fontSize: 13),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 12.w,
            ),
            hintText: "Search...",
            hintStyle: TextStyle(fontSize: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0x7F2E2E2E)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}

class PromotionScreenTextInput extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final IconData? icon;
  final int? maxLines;
  final int? maxLength;
  final bool isPrefixIconRequired;
  const PromotionScreenTextInput({
    super.key,
    required this.labelText,
    this.icon,
    this.maxLines,
    this.maxLength,
    required this.controller,
    required this.isPrefixIconRequired,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLength,
      controller: controller,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: isPrefixIconRequired ? Icon(icon) : SizedBox(),
        alignLabelWithHint: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
