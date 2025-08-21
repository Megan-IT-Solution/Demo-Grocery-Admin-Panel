import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String fromUserId;
  String toUserId;
  String title;
  String body;
  String notificationType;
  DateTime createdAt;
  String orderId;
  bool isRead;

  NotificationModel({
    required this.fromUserId,
    required this.toUserId,
    required this.title,
    required this.body,
    required this.notificationType,
    required this.createdAt,
    required this.orderId,
    required this.isRead,
  });

  factory NotificationModel.fromMap(DocumentSnapshot map) {
    return NotificationModel(
      fromUserId: map['fromUserId'] ?? '',
      toUserId: map['toUserId'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      notificationType: map['notificationType'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      orderId: map['orderId'] ?? '',
      isRead: map['isRead'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'title': title,
      'body': body,
      'notificationType': notificationType,
      'createdAt': createdAt,
      'orderId': orderId,
      'isRead': isRead,
    };
  }
}
