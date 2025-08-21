import 'package:flutter/material.dart';

import '../../../../constants/custom_msgs.dart';
import 'assign_rider_dialog.dart';

Widget actionMenuWidgetOrderScreen(
  BuildContext context,
  Map<String, dynamic> order,
) {
  return Center(
    child: PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == 'Assign') {
          order['orderStatus'] == 'assigned'
              ? showCustomMsg(context, "Already Assigned")
              : showDialog(
                context: context,
                builder:
                    (context) => AssignRiderDialog(
                      orderId: order['orderId'],
                      userId: order['userId'],
                    ),
              );
        } else if (value == 'Delete') {
          // Your delete order logic here
        }
      },
      itemBuilder: (BuildContext context) {
        return {'Assign', 'Delete'}.map((String choice) {
          return PopupMenuItem<String>(value: choice, child: Text(choice));
        }).toList();
      },
    ),
  );
}
