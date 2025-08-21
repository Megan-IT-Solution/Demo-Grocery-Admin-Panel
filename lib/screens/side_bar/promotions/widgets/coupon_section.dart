import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_admin_panel/screens/side_bar/promotions/widgets/promotion_section_card.dart';
import 'package:grocery_admin_panel/screens/side_bar/promotions/widgets/show_all_coupon_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../constants/custom_msgs.dart';
import '../../../../controllers/loading_controller.dart';
import '../../../../controllers/promotion_controller.dart';
import '../../../../widgets/buttons.dart';
import '../../../../widgets/text_inputs.dart';
import 'coupon_display_list.dart';

class CouponSection extends StatelessWidget {
  final PromotionController controller;

  const CouponSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PromotionSectionCard(
      title: "2. Add Coupon Code",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Instructions",
                  style: AppTextStyles.h1.copyWith(fontSize: 20.sp),
                ),
                const SizedBox(height: 10),
                const Text(
                  "• Coupon should be greater than 4 characters (Alpha-Numeric)",
                ),
                const Text("• All characters should be capital letters"),
                const SizedBox(height: 16),
                PromotionScreenTextInput(
                  labelText: "Coupon Code",
                  controller: controller.couponCodeController,
                  isPrefixIconRequired: true,
                  icon: Icons.discount_rounded,
                ),
                const SizedBox(height: 12),
                PromotionScreenTextInput(
                  labelText: "Discount (%)",
                  controller: controller.discountController,
                  isPrefixIconRequired: true,
                  icon: Icons.percent,
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(const Duration(days: 7)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      controller.expireAt = selectedDate;
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Expiry Date",
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.expireAt != null
                              ? DateFormat(
                                'dd MMM yyyy',
                              ).format(controller.expireAt!)
                              : "Select date",
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Consumer<LoadingController>(
                  builder: (context, loadingController, _) {
                    return loadingController.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SecondaryButton(
                          title: "Save Coupon",
                          btnColor: AppColors.primaryColor,
                          onPressed: () async {
                            final discount = double.tryParse(
                              controller.discountController.text.trim(),
                            );
                            final expireAt = controller.expireAt;

                            if (discount == null) {
                              showCustomMsg(
                                context,
                                'Please enter a valid discount',
                              );
                              return;
                            }
                            if (expireAt == null) {
                              showCustomMsg(
                                context,
                                'Please select an expiry date',
                              );
                              return;
                            }

                            await controller.saveCoupon(
                              context: context,
                              code: controller.couponCodeController.text.trim(),
                              discount: discount,
                              expireAt: expireAt,
                            );
                          },
                        );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "All Coupons",
                style: AppTextStyles.h1.copyWith(fontSize: 18.sp),
              ),
              SizedBox(
                height: 35,
                child: SecondaryButton(
                  fontSize: 13,
                  width: 150,
                  title: "Show All Coupons",
                  btnColor: AppColors.primaryColor,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const ShowAllCouponsDialog(),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const CouponDisplayList(),
        ],
      ),
    );
  }
}
