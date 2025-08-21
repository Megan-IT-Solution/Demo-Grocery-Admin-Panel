import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/app_colors.dart';
import '../main.dart';
import '../models/notification_model.dart';
import '../notification_handler/fcm_access_token.dart';
import '../widgets/buttons.dart';

class NotificationServices {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> getPermissionAndToken() async {
    try {
      final settings = await messaging.requestPermission();

      final granted = settings.authorizationStatus;
      if (granted == AuthorizationStatus.authorized ||
          granted == AuthorizationStatus.provisional) {
        final token = await messaging.getToken(
          vapidKey:
              'BAoVekiXHtQZepsK8k9z6est2e-VZwA3Q9VMyHJNGduTaazjdno77ietpWuLr_EbWYirVFuS9DnL7-YwjDi-1Ew',
        );

        final user = FirebaseAuth.instance.currentUser;
        if (token == null) {
          if (kDebugMode) print('FCM token came back null.');
          return;
        }
        if (user == null) {
          if (kDebugMode) print('No logged‑in user — cannot save token.');
          return;
        }

        await FirebaseFirestore.instance.collection('tokens').doc(user.uid).set(
          {'token': token},
        );

        if (kDebugMode) print('FCM Web Token saved: $token');

        messaging.onTokenRefresh.listen((newToken) async {
          if (kDebugMode) print('FCM token refreshed: $newToken');
          await FirebaseFirestore.instance
              .collection('tokens')
              .doc(user.uid)
              .set({'token': newToken});
        });
      } else {
        if (kDebugMode) print('Notification permission NOT granted.');
      }
    } catch (e) {
      if (kDebugMode) print('getPermissionAndToken error: $e');
    }
  }

  void initFCMListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print(
          'Foreground Notification Received: ${message.notification?.title}',
        );
      }

      if (message.notification != null) {
        showDialog(
          context: navigatorKey.currentContext!,
          builder:
              (_) => AlertDialog(
                title: Text(message.notification!.title ?? 'No Title'),
                content: Text(message.notification!.body ?? 'No Body'),
                actions: [
                  SecondaryButton(
                    title: "Okay",
                    btnColor: AppColors.primaryColor,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
        );
      }
    });
  }

  Future<void> sendNotificationToSpecificUser({
    required String title,
    required String body,
    required String toUserId,
  }) async {
    try {
      final tokenSnap =
          await FirebaseFirestore.instance
              .collection('tokens')
              .doc(toUserId)
              .get();

      if (!tokenSnap.exists || tokenSnap['token'] == null) {
        if (kDebugMode) print("User token not found.");
        return;
      }

      final fcmAccessToken = FcmAccessToken();
      final accessToken = await fcmAccessToken.getAccessToken();

      final notificationHeader = {
        'Content-Type': "application/json",
        'Authorization': "Bearer $accessToken",
      };

      final notificationBody = {'title': title, 'body': body};
      final notificationData = {
        'status': "done",
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'click_action': "FLUTTER_NOTIFICATION_CLICK",
      };

      final notificationFormat = {
        'message': {
          'notification': notificationBody,
          'data': notificationData,
          'token': tokenSnap['token'],
        },
      };

      final response = await http.post(
        Uri.parse(
          "https://fcm.googleapis.com/v1/projects/grocery-6c200/messages:send",
        ),
        headers: notificationHeader,
        body: jsonEncode(notificationFormat),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) print("Notification sent successfully");
      } else {
        if (kDebugMode) print("Failed to send notification: ${response.body}");
      }
    } catch (e) {
      if (kDebugMode) print("sendNotificationToSpecificUser error: $e");
    }
  }

  static Future<void> saveNotification({
    required String toUserId,
    required String title,
    required String body,
    required String notificationType,
    required String orderId,
  }) async {
    try {
      final notificationModel = NotificationModel(
        fromUserId: FirebaseAuth.instance.currentUser!.uid,
        toUserId: toUserId,
        title: title,
        body: body,
        notificationType: notificationType,
        createdAt: DateTime.now(),
        orderId: orderId,
        isRead: false,
      );

      await FirebaseFirestore.instance
          .collection('notifications')
          .add(notificationModel.toMap());
    } catch (e) {
      if (kDebugMode) print("saveNotification error: $e");
    }
  }

  Future<void> sendNotificationToAllUsers({
    required String title,
    required String body,
  }) async {
    try {
      final tokensSnapshot =
          await FirebaseFirestore.instance.collection('tokens').get();

      if (tokensSnapshot.docs.isEmpty) {
        if (kDebugMode) print("No user tokens found.");
        return;
      }

      final fcmAccessToken = FcmAccessToken();
      final accessToken = await fcmAccessToken.getAccessToken();

      final notificationHeader = {
        'Content-Type': "application/json",
        'Authorization': "Bearer $accessToken",
      };

      for (final doc in tokensSnapshot.docs) {
        final token = doc.data()['token'];
        final toUserId = doc.id;
        if (token == null || token.isEmpty) continue;

        final notificationBody = {'title': title, 'body': body};
        final notificationData = {
          'status': "done",
          'fromUserId': FirebaseAuth.instance.currentUser?.uid ?? '',
          'click_action': "FLUTTER_NOTIFICATION_CLICK",
        };

        final notificationFormat = {
          'message': {
            'notification': notificationBody,
            'data': notificationData,
            'token': token,
          },
        };

        final response = await http.post(
          Uri.parse(
            "https://fcm.googleapis.com/v1/projects/grocery-6c200/messages:send",
          ),
          headers: notificationHeader,
          body: jsonEncode(notificationFormat),
        );

        if (response.statusCode == 200) {
          if (kDebugMode) print("✅ Notification sent to: $token");

          final notificationModel = NotificationModel(
            fromUserId: FirebaseAuth.instance.currentUser!.uid,
            toUserId: toUserId,
            title: title,
            body: body,
            notificationType: "discount",
            createdAt: DateTime.now(),
            orderId: "",
            isRead: false,
          );

          await FirebaseFirestore.instance
              .collection('notifications')
              .add(notificationModel.toMap());
        } else {
          if (kDebugMode) print("❌ Failed for $token: ${response.body}");
        }
      }
    } catch (e) {
      if (kDebugMode) print("sendNotificationToAllUsers error: $e");
    }
  }
}
