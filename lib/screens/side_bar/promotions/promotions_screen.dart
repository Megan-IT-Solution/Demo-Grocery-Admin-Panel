import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_admin_panel/screens/side_bar/promotions/widgets/coupon_section.dart';
import 'package:grocery_admin_panel/screens/side_bar/promotions/widgets/send_discount_notification_section.dart';
import 'package:grocery_admin_panel/screens/side_bar/promotions/widgets/upload_and_display_banner_section.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_text_styles.dart';
import '../../../controllers/promotion_controller.dart';

class PromotionScreen extends StatelessWidget {
  const PromotionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PromotionController()..fetchOldBanners(),
      child: Consumer<PromotionController>(
        builder: (context, controller, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 26),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Promotions",
                    style: AppTextStyles.nunitoBold.copyWith(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const UploadAndDisplayBannerSection(),
                  const SizedBox(height: 20),
                  CouponSection(controller: controller),
                  const SizedBox(height: 20),
                  SendNotificationSection(controller: controller),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
