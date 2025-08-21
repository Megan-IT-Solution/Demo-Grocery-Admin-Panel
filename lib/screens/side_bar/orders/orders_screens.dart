import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_admin_panel/screens/side_bar/orders/widgets/order_status_dropdown_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../widgets/text_inputs.dart';
import 'widgets/show_orders.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String _selectedFilter = 'All Orders';
  String _searchQuery = '';

  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  List<Map<String, dynamic>> _filterOrders(
    List<Map<String, dynamic>> allOrders,
  ) {
    return allOrders.where((order) {
      final matchStatus =
          _selectedFilter == 'All Orders'
              ? true
              : (order['orderStatus'] ?? '').toString().toLowerCase() ==
                  _selectedFilter.toLowerCase().split(" ")[0];

      final matchSearch =
          _searchQuery.isEmpty
              ? true
              : (order['userName'] ?? '').toString().toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  ) ||
                  (order['userEmail'] ?? '').toString().toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  ) ||
                  (order['orderId'] ?? '').toString().toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  );

      return matchStatus && matchSearch;
    }).toList();
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Orders",
            style: AppTextStyles.nunitoBold.copyWith(
              fontSize: 40.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 120.h,
            padding: const EdgeInsets.symmetric(horizontal: 19),
            decoration: BoxDecoration(
              color: AppColors.primaryWhite,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Text(
                  "Total Orders",
                  style: AppTextStyles.nunitoSemiBod.copyWith(fontSize: 20.sp),
                ),
                SizedBox(width: 12.w),
                OrderStatusDropdownWidget(
                  selectedFilterValue: _selectedFilter,
                  onChanged: (v) {
                    setState(() {
                      _selectedFilter = v!;
                    });
                  },
                ),
                const Spacer(),
                Text(
                  "${AppStrings.search}:",
                  style: AppTextStyles.nunitoBold.copyWith(fontSize: 22.sp),
                ),
                SizedBox(width: 22.w),
                SizedBox(
                  width: 300.w,
                  child: SearchTextInput(
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('orders').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 150),
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No orders found"));
                }

                final orders =
                    snapshot.data!.docs.map((doc) {
                      final data = doc.data()! as Map<String, dynamic>;
                      return {
                        'orderId': data['orderId'] ?? '',
                        'uniqueOrderId': data['uniqueOrderId'] ?? '',
                        'userName': data['userName'] ?? '',
                        'userEmail': data['userEmail'] ?? '',
                        'paymentMethod': data['paymentMethod'] ?? '',
                        'totalAmount': (data['totalAmount'] ?? 0).toDouble(),
                        'orderStatus': data['orderStatus'] ?? '',
                        'paymentStatus': data['paymentStatus'] ?? '',
                        'address': data['address'] ?? {},
                        'products': data['products'] ?? [],
                        'userId': data['userId'] ?? '',
                        'timestamp': data['timestamp'],
                      };
                    }).toList();

                final filteredOrders = _filterOrders(orders);

                return ShowOrders(orders: filteredOrders);
              },
            ),
          ),
        ],
      ),
    );
  }
}
