import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_products.dart';

class OrderModel {
  final String orderId;
  final String uniqueOrderId;
  final String assignedRiderId;
  final List<CartProduct> products;
  final double totalAmount;
  final Map<String, dynamic> address;
  final String userId;
  final String userName;
  final String userEmail;
  final int phoneNumber;
  final String orderStatus;
  final DateTime timestamp;
  final DateTime deliveredTimeStamp;
  final String paymentMethod;
  String paymentStatus;
  final bool isRatingDone;
  final DateTime selectedDeliveryDate;
  final String selectedTimeSlot;
  final String? couponCode;
  final double? discountAmount;
  final double? discountPercentage;
  final double originalAmount;

  OrderModel({
    required this.orderId,
    required this.uniqueOrderId,
    required this.assignedRiderId,
    required this.products,
    required this.totalAmount,
    required this.address,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.phoneNumber,
    required this.orderStatus,
    required this.timestamp,
    required this.deliveredTimeStamp,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.isRatingDone,
    required this.selectedDeliveryDate,
    required this.selectedTimeSlot,
    this.couponCode,
    this.discountAmount,
    this.discountPercentage,
    required this.originalAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'uniqueOrderId': uniqueOrderId,
      'assignedRiderId': assignedRiderId,
      'products': products.map((p) => p.toJson()).toList(),
      'totalAmount': totalAmount,
      'address': address,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'phoneNumber': phoneNumber,
      'orderStatus': orderStatus,
      'timestamp': timestamp,
      'deliveredTimeStamp': deliveredTimeStamp,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'isRatingDone': isRatingDone,
      'selectedDeliveryDate': selectedDeliveryDate,
      'selectedTimeSlot': selectedTimeSlot,
      'couponCode': couponCode,
      'discountAmount': discountAmount,
      'discountPercentage': discountPercentage,
      'originalAmount': originalAmount,
    };
  }

  factory OrderModel.fromMap(DocumentSnapshot json) {
    final data = json.data() as Map<String, dynamic>;
    return OrderModel(
      orderId: data['orderId'],
      uniqueOrderId: data['uniqueOrderId'],
      assignedRiderId: data['assignedRiderId'],
      products:
          (data['products'] as List<dynamic>)
              .map((e) => CartProduct.fromJson(e as Map<String, dynamic>))
              .toList(),
      totalAmount: (data['totalAmount'] as num).toDouble(),
      address: Map<String, dynamic>.from(data['address']),
      userId: data['userId'],
      userName: data['userName'],
      userEmail: data['userEmail'],
      phoneNumber: data['phoneNumber'],
      orderStatus: data['orderStatus'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      deliveredTimeStamp: (data['deliveredTimeStamp'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'],
      paymentStatus: data['paymentStatus'],
      isRatingDone: data['isRatingDone'],
      selectedDeliveryDate:
          (data['selectedDeliveryDate'] as Timestamp).toDate(),
      selectedTimeSlot: data['selectedTimeSlot'],
      couponCode: data['couponCode'],
      discountAmount: (data['discountAmount'] as num?)?.toDouble(),
      discountPercentage: (data['discountPercentage'] as num?)?.toDouble(),
      originalAmount: (data['originalAmount'] as num).toDouble(),
    );
  }
}
