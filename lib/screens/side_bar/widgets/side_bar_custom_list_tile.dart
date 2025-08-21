import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_text_styles.dart';

class SideBarCustomListTile extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final String? icon;
  final String? title;
  final VoidCallback? onTap;
  const SideBarCustomListTile({
    super.key,
    this.backgroundColor,
    required this.icon,
    required this.title,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      child: ListTile(
        onTap: onTap ?? () {},
        leading: SizedBox(
          height: 40.h,
          width: 40.w,
          child: Image.asset(icon!, color: textColor),
        ),
        title: Text(
          title!,
          style: AppTextStyles.h1.copyWith(
            fontSize: 17.sp,
            color: textColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.7,
          ),
        ),
      ),
    );
  }
}
