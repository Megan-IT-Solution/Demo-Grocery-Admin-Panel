import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_text_styles.dart';

class OrderDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsDialog({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final address = order['address'] as Map<String, dynamic>? ?? {};
    final products = order['products'] as List<dynamic>? ?? [];

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 400,
        decoration: BoxDecoration(
          color: AppColors.primaryWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order Details",
                style: AppTextStyles.nunitoBold.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Order ID: ${order['uniqueOrderId'] ?? ''}",
                style: AppTextStyles.nunitoSemiBod,
              ),
              SizedBox(height: 5),
              Text(
                "Customer: ${order['address']['contactedPersonName'] ?? ''}",
                style: AppTextStyles.nunitoSemiBod,
              ),
              SizedBox(height: 5),
              Text(
                "Payment: ${order['paymentMethod'] ?? ''}",
                style: AppTextStyles.nunitoSemiBod,
              ),
              SizedBox(height: 5),
              Text(
                "Order Status: ${order['orderStatus'] ?? ''}",
                style: AppTextStyles.nunitoSemiBod,
              ),
              SizedBox(height: 5),
              Text(
                "Payment Status: ${order['paymentStatus'] ?? ''}",
                style: AppTextStyles.nunitoSemiBod,
              ),
              SizedBox(height: 5),
              Text(
                "Total Payment include (5% VAT): ${order['totalAmount'] ?? 0.0} AED",
                style: AppTextStyles.nunitoSemiBod,
              ),
              const Divider(),
              Text("Address:", style: AppTextStyles.nunitoBold),
              const SizedBox(height: 10),
              Text(
                "${address['address'] ?? ''}",
                style: AppTextStyles.nunitoSemiBod,
              ),
              Text(
                "Building Name/Number: ${address['buildingName'] ?? ''}",
                style: AppTextStyles.nunitoSemiBod,
              ),
              Text(
                "Door Number: ${address['doorNumber'] ?? ''}",
                style: AppTextStyles.nunitoSemiBod,
              ),
              const Divider(),
              Text("Products:", style: AppTextStyles.nunitoBold),
              const SizedBox(height: 10),
              ...products.map((product) {
                final p = product as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    "• ${p['pdtTitle'] ?? ''} x${p['quantity'] ?? 0} - ${p['selectedQuantityPrice'] ?? ''} AED  (${p['selectedQuantityLabel']})",
                    style: AppTextStyles.nunitoSemiBod,
                  ),
                );
              }),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                  child: const Text("Close"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
