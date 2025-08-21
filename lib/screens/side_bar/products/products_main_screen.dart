import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_admin_panel/screens/side_bar/products/widgets/show_product_widget.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../widgets/text_inputs.dart';
import 'add_new_product_screen.dart';

class ProductsMainScreen extends StatefulWidget {
  const ProductsMainScreen({super.key});

  @override
  State<ProductsMainScreen> createState() => _ProductsMainScreenState();
}

class _ProductsMainScreenState extends State<ProductsMainScreen> {
  String searchQuery = "";
  @override
  Widget build(BuildContext context) {
    final navigationController = Provider.of<NavigationController>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 46.w, vertical: 33.h),
      child:
          navigationController.categoryWidget ??
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Products",
                style: AppTextStyles.nunitoBold.copyWith(
                  fontSize: 45.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 30.h),
              Container(
                width: double.infinity,
                height: 120.h,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        navigationController.updateCategoryScreen(
                          const AddNewProductScreen(),
                        );
                      },
                      child: Container(
                        height: 80.h,
                        width: 300.w,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlack,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add New Product",
                              style: AppTextStyles.nunitoBold.copyWith(
                                fontSize: 16.sp,
                                color: AppColors.primaryWhite,
                              ),
                            ),
                            Icon(
                              Icons.add,
                              size: 30.sp,
                              color: AppColors.primaryWhite,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "${AppStrings.search}:",
                      style: AppTextStyles.nunitoBold.copyWith(fontSize: 22.sp),
                    ),
                    SizedBox(width: 22.w),
                    SizedBox(
                      width: 400.w,
                      child: SearchTextInput(
                        onChanged: (val) {
                          setState(() {
                            searchQuery = val!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),

              ShowProductWidget(searchQuery: searchQuery),
            ],
          ),
    );
  }
}
