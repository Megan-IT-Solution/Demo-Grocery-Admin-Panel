import 'package:cloud_firestore/cloud_firestore.dart';

class RiderModel {
  final String userId;
  final String riderName;
  final String email;
  final String password;
  final String image;
  final DateTime memberSince;
  final int phoneNumber;
  final String isAccountApproved;

  RiderModel({
    required this.userId,
    required this.riderName,
    required this.email,
    required this.password,
    required this.image,
    required this.memberSince,
    required this.phoneNumber,
    required this.isAccountApproved,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': riderName,
      'email': email,
      'image': image,
      'password': password,
      'memberSince': memberSince.toIso8601String(),
      'phoneNumber': phoneNumber,
      'isAccountApproved': isAccountApproved,
    };
  }

  factory RiderModel.fromMap(DocumentSnapshot map) {
    return RiderModel(
      userId: map['userId'],
      riderName: map['username'],
      email: map['email'],
      image: map['image'],
      password: map['password'],
      memberSince: DateTime.parse(map['memberSince']),
      phoneNumber: map['phoneNumber'],
      isAccountApproved: map['isAccountApproved'],
    );
  }
}
