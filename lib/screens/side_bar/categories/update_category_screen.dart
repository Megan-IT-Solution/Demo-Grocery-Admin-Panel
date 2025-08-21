import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_admin_panel/services/category_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../controllers/image_controller.dart';
import '../../../controllers/loading_controller.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../models/category_model.dart';
import '../../../services/storage_services.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/text_inputs.dart';

class UpdateCategoryScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  final VoidCallback? onTap;
  const UpdateCategoryScreen({
    super.key,
    this.onTap,
    required this.categoryModel,
  });

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  final TextEditingController titleController = TextEditingController();
  String? image;
  @override
  void initState() {
    titleController.text = widget.categoryModel.title!;
    image = widget.categoryModel.image!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loadingController = Provider.of<LoadingController>(context);
    final imageController = Provider.of<ImageController>(context);
    final navigationController = Provider.of<NavigationController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.categories,
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
            color: AppColors.primaryBlack,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            AppStrings.updateCategory,
            style: AppTextStyles.nunitoBold.copyWith(
              fontSize: 24.sp,
              color: AppColors.primaryWhite,
            ),
          ),
        ),
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
                AppStrings.categoryTitle,
                style: AppTextStyles.nunitoBold.copyWith(fontSize: 22.sp),
              ),
              SizedBox(height: 20.h),
              CategoryTextField(
                hintText: AppStrings.enterTitle,
                controller: titleController,
              ),
              const SizedBox(height: 30),
              Text(
                AppStrings.categoryImage,
                style: AppTextStyles.nunitoBold.copyWith(fontSize: 22.sp),
              ),
              const SizedBox(height: 20),
              Container(
                height: 60,
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.primaryBlack),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        imageController.uploadImage(ImageSource.gallery);
                      },
                      child: Container(
                        width: 220.w,
                        decoration: BoxDecoration(
                          color: const Color(0x70757575),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: Text(
                            AppStrings.chooseFile,
                            style: AppTextStyles.nunitoMedium.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      imageController.imageName ??
                          StorageServices().getImageNameFromFirebaseURL(image!),
                      style: AppTextStyles.nunitoMedium.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 45),
              Provider.of<LoadingController>(context, listen: false).isLoading
                  ? const CircularProgressIndicator()
                  : PrimaryButton(
                    title: AppStrings.update,
                    width: 220.w,
                    height: 90.h,
                    onTap: () async {
                      await CategoryServices.updateCategory(
                        context: context,
                        title: titleController.text,
                        id: widget.categoryModel.id!,
                        image: image!,
                      );
                      navigationController.updateCategoryScreen(null);
                    },
                  ),
            ],
          ),
        ),
      ],
    );
  }
}
