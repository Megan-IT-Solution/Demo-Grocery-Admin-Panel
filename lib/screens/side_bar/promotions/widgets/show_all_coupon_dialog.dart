import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'coupon_card.dart';

class ShowAllCouponsDialog extends StatelessWidget {
  const ShowAllCouponsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("All Coupons"),
      content: SizedBox(
        width: 500,
        height: 500,
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance
                  .collection('coupons')
                  .orderBy('expireAt', descending: true)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Text("No coupons found.");
            }

            final docs = snapshot.data!.docs;

            return ListView.separated(
              itemCount: docs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final data = docs[index].data() as Map<String, dynamic>;
                return CouponCard(
                  id: docs[index].id,
                  code: data['couponCode'] ?? 'N/A',
                  discount: data['discount']?.toString() ?? '0',
                  expireAt: (data['expireAt'] as Timestamp?)?.toDate(),
                );
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Close"),
        ),
      ],
    );
  }
}
