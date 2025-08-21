import 'package:cloud_firestore/cloud_firestore.dart';

class CouponModel {
  final String couponId;
  final String couponCode;
  final double discount;
  final bool isActive;
  final DateTime createdAt;
  final DateTime expireAt;

  CouponModel({
    required this.couponId,
    required this.couponCode,
    required this.discount,
    required this.isActive,
    required this.createdAt,
    required this.expireAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'couponId': couponId,
      'couponCode': couponCode,
      'discount': discount,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
      'expireAt': Timestamp.fromDate(expireAt),
    };
  }
}
