import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_admin_panel/screens/side_bar/products/widgets/dropdown_widget_add_product_screen.dart';
import 'package:grocery_admin_panel/screens/side_bar/products/widgets/image_picking_btn_widget.dart';
import 'package:grocery_admin_panel/services/product_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/custom_msgs.dart';
import '../../../controllers/image_controller.dart';
import '../../../controllers/loading_controller.dart';
import '../../../models/product_model.dart';
import '../../../utils/lists.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/text_inputs.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController salePriceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  String? selectedCategory;
  String? selectUnit;
  String? taxCategory;

  List<TextEditingController> quantityLabelControllers = [];
  List<TextEditingController> quantityPriceControllers = [];

  @override
  void initState() {
    super.initState();
    quantityLabelControllers.add(TextEditingController());
    quantityPriceControllers.add(TextEditingController());
  }

  @override
  void dispose() {
    for (var c in quantityLabelControllers) {
      c.dispose();
    }
    for (var c in quantityPriceControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loadingController = Provider.of<LoadingController>(context);
    final imageController = Provider.of<ImageController>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Products",
            style: AppTextStyles.nunitoBold.copyWith(
              fontSize: 45.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 45.h),
          Container(
            width: double.infinity,
            height: 90.h,
            padding: EdgeInsets.symmetric(horizontal: 29.w),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                "Add New Product",
                style: AppTextStyles.nunitoBold.copyWith(
                  fontSize: 24.sp,
                  color: AppColors.primaryWhite,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 29.w, vertical: 30.h),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: AppColors.primaryWhite,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Product Name",
                  style: AppTextStyles.nunitoBold.copyWith(fontSize: 22.sp),
                ),
                SizedBox(height: 20.h),
                CategoryTextField(
                  hintText: "Enter Product Name",
                  controller: productNameController,
                ),
                SizedBox(height: 30.h),
                Text(
                  "Product Description",
                  style: AppTextStyles.nunitoBold.copyWith(fontSize: 22.sp),
                ),
                SizedBox(height: 20.h),
                CategoryTextField(
                  hintText: "Enter Product Description",
                  controller: descriptionController,
                ),

                SizedBox(height: 30.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Actual Price",
                            style: AppTextStyles.nunitoBold.copyWith(
                              fontSize: 22.sp,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          CategoryTextField(
                            hintText: "Enter Price",
                            controller: priceController,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tax",
                            style: AppTextStyles.nunitoBold.copyWith(
                              fontSize: 22.sp,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          DropDownWidgetAddProductScreen(
                            hintText: "Tax Category",
                            dropDownValue: taxCategory,
                            dropDownList: taxCategoryList,
                            onChanged: (v) {
                              setState(() {
                                taxCategory = v;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.h),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Category",
                            style: AppTextStyles.nunitoBold.copyWith(
                              fontSize: 22.sp,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          StreamBuilder<QuerySnapshot>(
                            stream:
                                FirebaseFirestore.instance
                                    .collection('categories')
                                    .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              final categoriesList =
                                  snapshot.data!.docs
                                      .map((doc) => doc['title'].toString())
                                      .toList();

                              if (selectedCategory == null &&
                                  categoriesList.isNotEmpty) {
                                selectedCategory = categoriesList.first;
                              }

                              return DropDownWidgetAddProductScreen(
                                hintText: "Select Category",
                                dropDownValue: selectedCategory,
                                dropDownList: categoriesList,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCategory = value;
                                  });
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Stock",
                            style: AppTextStyles.nunitoBold.copyWith(
                              fontSize: 22.sp,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          CategoryTextField(
                            hintText: "Enter Total Stock",
                            controller: stockController,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.h),
                Text(
                  "Quantity Options (Label & Price)",
                  style: AppTextStyles.nunitoBold.copyWith(fontSize: 22.sp),
                ),
                SizedBox(height: 10.h),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: quantityLabelControllers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CategoryTextField(
                              hintText: "Label (e.g. 250g)",
                              controller: quantityLabelControllers[index],
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            flex: 2,
                            child: CategoryTextField(
                              hintText: "Price",
                              controller: quantityPriceControllers[index],
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          IconButton(
                            icon: Icon(Icons.remove_circle, color: Colors.red),
                            onPressed: () {
                              if (quantityLabelControllers.length > 1) {
                                setState(() {
                                  quantityLabelControllers.removeAt(index);
                                  quantityPriceControllers.removeAt(index);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),

                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text("Add Quantity Option"),
                    onPressed: () {
                      setState(() {
                        quantityLabelControllers.add(TextEditingController());
                        quantityPriceControllers.add(TextEditingController());
                      });
                    },
                  ),
                ),

                SizedBox(height: 30.h),
                Text(
                  AppStrings.categoryImage,
                  style: AppTextStyles.nunitoBold.copyWith(fontSize: 22.sp),
                ),
                SizedBox(height: 20.h),

                ImagePickingBtnWidget(
                  onPressed: () {
                    imageController.uploadImage(ImageSource.gallery);
                  },
                  title: imageController.imageName ?? AppStrings.noFileChosen,
                ),

                SizedBox(height: 45.h),

                loadingController.isLoading
                    ? const CircularProgressIndicator()
                    : PrimaryButton(
                      title: AppStrings.submit,
                      width: 220.w,
                      height: 70.h,
                      onTap: () async {
                        List<QuantityOption> quantities = [];

                        for (
                          int i = 0;
                          i < quantityLabelControllers.length;
                          i++
                        ) {
                          final label = quantityLabelControllers[i].text.trim();
                          final priceText =
                              quantityPriceControllers[i].text.trim();

                          if (label.isNotEmpty && priceText.isNotEmpty) {
                            final price = double.tryParse(priceText);
                            if (price == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Invalid price at quantity option ${i + 1}",
                                  ),
                                ),
                              );
                              return;
                            }
                            quantities.add(
                              QuantityOption(label: label, price: price),
                            );
                          }
                        }

                        if (quantities.isEmpty) {
                          showCustomMsg(
                            context,
                            "Please add at least one quantity option with valid label and price",
                          );

                          return;
                        }

                        loadingController.setLoading(true);

                        try {
                          await ProductServices().addProduct(
                            context: context,
                            productName: productNameController.text.trim(),
                            description: descriptionController.text.trim(),
                            price: double.parse(priceController.text.trim()),
                            totalStock: int.parse(stockController.text.trim()),
                            category: selectedCategory!,
                            image: imageController.selectedImage,
                            taxCategory: taxCategory!,
                            quantities: quantities,
                          );

                          loadingController.setLoading(false);
                        } catch (e) {
                          loadingController.setLoading(false);
                          if (!context.mounted) return;
                          showCustomMsg(context, "Failed to add product: $e");
                        }
                      },
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
