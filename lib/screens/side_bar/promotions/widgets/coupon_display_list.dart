import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'coupon_card.dart';

class CouponDisplayList extends StatelessWidget {
  const CouponDisplayList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance
              .collection('coupons')
              .orderBy('createdAt', descending: true)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text("No coupons available.");
        }

        final docs = snapshot.data!.docs;
        final topTwo = docs.take(2).toList();

        return Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: topTwo.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final data = topTwo[index].data() as Map<String, dynamic>;
                return CouponCard(
                  id: docs[index].id,
                  code: data['couponCode'] ?? 'N/A',
                  discount: data['discount']?.toString() ?? '0',
                  expireAt: (data['expireAt'] as Timestamp?)?.toDate(),
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
