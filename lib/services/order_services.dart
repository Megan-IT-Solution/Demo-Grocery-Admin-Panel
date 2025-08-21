import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../controllers/loading_controller.dart';
import 'notification_services.dart';

class OrderServices {
  assignOrderToRider({
    required BuildContext context,
    required String riderId,
    required orderId,
  }) async {
    final loadingController = Provider.of<LoadingController>(
      context,
      listen: false,
    );

    try {
      loadingController.setLoading(true);

      await FirebaseFirestore.instance
          .collection('riders')
          .doc(riderId)
          .collection("assignedOrders")
          .add({'orderId': orderId, 'assignedAt': DateTime.now()})
          .whenComplete(() async {
            await FirebaseFirestore.instance
                .collection('orders')
                .doc(orderId)
                .update({
                  "orderStatus": "assigned",
                  "assignedRiderId": riderId,
                });
            await NotificationServices().sendNotificationToSpecificUser(
              title: "New Order",
              body: "New Order is Assigned To you",
              toUserId: riderId,
            );
            await NotificationServices.saveNotification(
              toUserId: riderId,
              title: "New Order",
              body: "A New Order is Assigned To you",
              notificationType: "Order",
              orderId: orderId,
            );
          });
      loadingController.setLoading(false);
    } on FirebaseException catch (e) {
      loadingController.setLoading(false);
      print(e);
    }
  }
}
