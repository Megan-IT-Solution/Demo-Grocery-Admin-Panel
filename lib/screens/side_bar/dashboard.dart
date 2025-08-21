import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_admin_panel/screens/side_bar/widgets/dashboard_custom_tile.dart';
import 'package:provider/provider.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../controllers/navigation_controller.dart';
import '../../services/notification_services.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    NotificationServices().getPermissionAndToken();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navigationController = Provider.of<NavigationController>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              AppStrings.dashboard,
              style: AppTextStyles.nunitoBold.copyWith(
                fontSize: 50.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 30.h),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Wrap(
                  spacing: 65,
                  runSpacing: 31,
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream:
                          FirebaseFirestore.instance
                              .collection('orders')
                              .where('orderStatus', isEqualTo: 'completed')
                              .snapshots(),
                      builder: (context, snapshot) {
                        double totalRevenue = 0.0;

                        if (snapshot.hasData) {
                          for (var doc in snapshot.data!.docs) {
                            final data = doc.data() as Map<String, dynamic>;
                            totalRevenue +=
                                (data['totalAmount'] ?? 0).toDouble();
                          }
                        }

                        return DashboardCustomTile(
                          backgroundColor: const Color(0xFF27B097),
                          title: "${totalRevenue.toStringAsFixed(2)} AED",
                          subTitle: AppStrings.totalRevenue,
                          icon: AppAssets.totalRevenue,
                          bottomColor: const Color(0xFF1EA38B),
                        );
                      },
                    ),

                    StreamBuilder<QuerySnapshot>(
                      stream:
                          FirebaseFirestore.instance
                              .collection('orders')
                              .snapshots(),
                      builder: (context, snapshot) {
                        int totalOrders = snapshot.data?.docs.length ?? 0;
                        return DashboardCustomTile(
                          onTap: () {
                            navigationController.updateSideBarIndex(1);
                            navigationController.updateClientListingIndex(0);
                          },
                          backgroundColor: Color(0xFF0A9AB0),
                          title: "$totalOrders",
                          subTitle: "Total Orders",
                          icon: "assets/icons/orders.png",
                          bottomColor: Color(0xFF0290A4),
                        );
                      },
                    ),

                    Wrap(
                      spacing: 65,
                      runSpacing: 31,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream:
                              FirebaseFirestore.instance
                                  .collection('products')
                                  .snapshots(),
                          builder: (context, snapshot) {
                            int totalProducts = snapshot.data?.docs.length ?? 0;
                            return DashboardCustomTile(
                              onTap: () {
                                navigationController.updateSideBarIndex(2);
                                navigationController.updateCreativeListingIndex(
                                  0,
                                );
                              },
                              backgroundColor: Color(0xFF3F51B5),
                              title: "$totalProducts",
                              subTitle: "Products",
                              icon: "assets/icons/products.png",
                              bottomColor: Color(0xFF3749AE),
                            );
                          },
                        ),

                        StreamBuilder<QuerySnapshot>(
                          stream:
                              FirebaseFirestore.instance
                                  .collection('categories')
                                  .snapshots(),
                          builder: (context, snapshot) {
                            int totalCategories =
                                snapshot.data?.docs.length ?? 0;
                            return DashboardCustomTile(
                              onTap: () {
                                navigationController.updateSideBarIndex(3);
                                navigationController.updateCreativeListingIndex(
                                  1,
                                );
                              },
                              backgroundColor: const Color(0xFFFF9800),
                              title: "$totalCategories",
                              subTitle: "Categories",
                              icon: "assets/icons/categories.png",
                              bottomColor: const Color(0xFFED8D00),
                            );
                          },
                        ),

                        StreamBuilder<QuerySnapshot>(
                          stream:
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .snapshots(),
                          builder: (context, snapshot) {
                            int totalMembers = snapshot.data?.docs.length ?? 0;
                            return DashboardCustomTile(
                              onTap: () {
                                // navigationController.updateSideBarIndex(4);
                                // navigationController.updateCreativeListingIndex(2);
                              },
                              backgroundColor: const Color(0xFFAFC23B),
                              title: "$totalMembers",
                              subTitle: "Total Members",
                              icon: "assets/icons/users.png",
                              bottomColor: const Color(0xFF9EB031),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
