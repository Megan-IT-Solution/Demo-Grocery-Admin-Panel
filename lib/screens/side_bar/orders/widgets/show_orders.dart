import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_text_styles.dart';
import '../../widgets/table_header_widget.dart';
import 'action_menu_widget_order_screen.dart';
import 'order_detail_dialog_widget.dart';
import 'table_cell_widget_order_screen.dart';

class ShowOrders extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  const ShowOrders({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(5),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Table(
                defaultColumnWidth: FixedColumnWidth(180.w),
                border: TableBorder.all(color: const Color(0x33474747)),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: AppColors.primaryColor),
                    children: [
                      tableHeaderWidget('Order ID'),
                      tableHeaderWidget('Customer Name'),
                      tableHeaderWidget('Payment Method'),
                      tableHeaderWidget('Total Amount'),
                      tableHeaderWidget('Order Status'),
                      tableHeaderWidget('Details'),
                      tableHeaderWidget('Actions'),
                    ],
                  ),
                  ...orders.map((order) {
                    return TableRow(
                      children: [
                        tableCellWidgetOrderScreen(
                          order['uniqueOrderId'] ?? '',
                          isBold: true,
                        ),
                        tableCellWidgetOrderScreen(
                          order['address']['contactedPersonName'] ?? '',
                        ),
                        tableCellWidgetOrderScreen(
                          order['paymentMethod'] ?? '',
                        ),
                        tableCellWidgetOrderScreen(
                          "${(order['totalAmount'] ?? 0).toDouble().toStringAsFixed(2)} AED",
                        ),
                        tableCellWidgetOrderScreen(
                          order['orderStatus'] ?? '',
                          isBold: order['orderStatus'] == "completed",
                          textColor:
                              order['orderStatus'] == 'completed'
                                  ? AppColors.primaryColor
                                  : AppColors.primaryBlack,
                        ),
                        TableCell(
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (ctx) => OrderDetailsDialog(order: order),
                                );
                              },
                              child: Text(
                                "Show Details",
                                style: AppTextStyles.nunitoMedium.copyWith(
                                  fontSize: 14.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        actionMenuWidgetOrderScreen(context, order),
                      ],
                    );
                  }),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
