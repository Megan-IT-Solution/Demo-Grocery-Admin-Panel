import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../controllers/navigation_controller.dart';
import '../../../../models/category_model.dart';
import '../../widgets/padded_text_widget.dart';
import '../../widgets/table_header_widget.dart';
import '../update_category_screen.dart';

class ShowCategoryWidget extends StatelessWidget {
  final String searchQuery;
  const ShowCategoryWidget({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final navigationController = Provider.of<NavigationController>(context);
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('categories').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "No Category Found",
                  style: AppTextStyles.nunitoBold,
                ),
              );
            }

            final categories =
                snapshot.data!.docs
                    .map((item) => CategoryModel.fromDoc(item))
                    .where(
                      (category) => category.title
                          .toString()
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()),
                    )
                    .toList();

            if (categories.isEmpty) {
              return Center(
                child: Text(
                  "No matching categories found",
                  style: AppTextStyles.nunitoBold,
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Table(
                    border: TableBorder.all(color: const Color(0x33474747)),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(3),
                      3: FlexColumnWidth(2),
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                        ),
                        children: [
                          tableHeaderWidget("Image"),
                          tableHeaderWidget("Category Name"),
                          tableHeaderWidget("Created At"),
                          tableHeaderWidget("Actions"),
                        ],
                      ),
                      ...categories.map((category) {
                        return TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.w),
                              child: SizedBox(
                                height: 95.h,
                                width: double.infinity,
                                child: Image.network(
                                  category.image!,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            paddedTextWidget(category.title),
                            paddedTextWidget(
                              DateFormat(
                                'dd MMMM yyy',
                              ).format(category.createdAt!),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.w),
                              child: PopupMenuButton<String>(
                                icon: const Icon(Icons.more_vert),
                                onSelected: (value) async {
                                  if (value == "Update") {
                                    navigationController.updateCategoryScreen(
                                      UpdateCategoryScreen(
                                        categoryModel: category,
                                      ),
                                    );
                                  } else if (value == "Delete") {
                                    await FirebaseFirestore.instance
                                        .collection('categories')
                                        .doc(category.id)
                                        .delete();
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
      ),
    );
  }
}
