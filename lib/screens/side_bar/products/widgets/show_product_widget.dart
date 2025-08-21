import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_admin_panel/screens/side_bar/products/widgets/update_product_form_widget.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../controllers/image_controller.dart';
import '../../../../controllers/loading_controller.dart';
import '../../../../models/product_model.dart';
import '../../../../services/product_services.dart';
import '../../widgets/padded_text_widget.dart';
import '../../widgets/table_header_widget.dart';

class ShowProductWidget extends StatelessWidget {
  final String searchQuery;

  const ShowProductWidget({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.7,
      width: double.infinity,
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No Product Found", style: AppTextStyles.nunitoBold),
            );
          }

          final products =
              snapshot.data!.docs
                  .map((item) => ProductModel.fromMap(item))
                  .where(
                    (product) => product.pdtName.toLowerCase().contains(
                      searchQuery.toLowerCase(),
                    ),
                  )
                  .toList();

          if (products.isEmpty) {
            return Center(
              child: Text(
                "No matching products found",
                style: AppTextStyles.nunitoBold,
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Table(
                  defaultColumnWidth: FixedColumnWidth(160.w),
                  border: TableBorder.all(color: const Color(0x33474747)),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: AppColors.primaryColor),
                      children: [
                        tableHeaderWidget("Image"),
                        tableHeaderWidget("Product Name"),
                        tableHeaderWidget("Category"),
                        tableHeaderWidget("Price"),
                        tableHeaderWidget("Stock"),
                        tableHeaderWidget("Status"),
                        tableHeaderWidget("Actions"),
                      ],
                    ),
                    ...products.map((product) {
                      final firstQuantity =
                          (product.quantities.isNotEmpty)
                              ? product.quantities.first
                              : null;

                      return TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.w),
                            child: SizedBox(
                              height: 85.h,
                              width: 65.w,
                              child: Image.network(
                                product.pdtImage,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                          paddedTextWidget(product.pdtName),
                          paddedTextWidget(product.category),
                          paddedTextWidget(
                            firstQuantity != null
                                ? "${firstQuantity.price.toStringAsFixed(2)} / ${firstQuantity.label}"
                                : "--",
                          ),
                          paddedTextWidget(product.totalStock.toString()),
                          paddedTextWidget(product.status),
                          Padding(
                            padding: EdgeInsets.all(10.w),
                            child: PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert),
                              onSelected: (value) async {
                                if (value == "Update") {
                                  showDialog(
                                    context: context,
                                    useRootNavigator: false,
                                    builder:
                                        (_) => ChangeNotifierProvider.value(
                                          value: Provider.of<ImageController>(
                                            context,
                                            listen: false,
                                          ),
                                          child: ChangeNotifierProvider.value(
                                            value:
                                                Provider.of<LoadingController>(
                                                  context,
                                                  listen: false,
                                                ),
                                            child: UpdateProductForm(
                                              product: product,
                                            ),
                                          ),
                                        ),
                                  );
                                } else if (value == "Delete") {
                                  await ProductServices().deleteProductFromDB(
                                    context,
                                    product.pdtId,
                                  );
                                }
                              },
                              itemBuilder:
                                  (context) => const [
                                    PopupMenuItem(
                                      value: 'Update',
                                      child: Text('Update'),
                                    ),
                                    PopupMenuItem(
                                      value: 'Delete',
                                      child: Text('Delete'),
                                    ),
                                  ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
