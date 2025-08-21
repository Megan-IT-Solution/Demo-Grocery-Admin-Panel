import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants/custom_msgs.dart';
import '../../../../widgets/buttons.dart';

class CouponCard extends StatelessWidget {
  final String id;
  final String code;
  final String discount;
  final DateTime? expireAt;

  const CouponCard({
    super.key,
    required this.id,
    required this.code,
    required this.discount,
    this.expireAt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Code: $code"),
              Text("Discount: $discount%"),
              if (expireAt != null)
                Text("Expires: ${DateFormat('dd MMM yyyy').format(expireAt!)}"),
            ],
          ),

          SizedBox(
            height: 35,
            child: SecondaryButton(
              width: 80,
              title: 'Delete',
              btnColor: Colors.red,
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('coupons')
                    .doc(id)
                    .delete()
                    .then((_) => showCustomMsg(context, "Coupon Deleted"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
