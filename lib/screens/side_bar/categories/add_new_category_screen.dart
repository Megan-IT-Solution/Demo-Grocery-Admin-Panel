import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_admin_panel/screens/side_bar/categories/widget/add_new_category_header_widget.dart';
import 'package:grocery_admin_panel/services/category_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../controllers/image_controller.dart';
import '../../../controllers/loading_controller.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/text_inputs.dart';

class AddNewCategoryScreen extends StatefulWidget {
  const AddNewCategoryScreen({super.key});

  @override
  State<AddNewCategoryScreen> createState() => _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends State<AddNewCategoryScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
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
        SizedBox(height: 25.h),
        AddNewCategoryHeaderWidget(),
        SizedBox(height: 20.h),
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

              const SizedBox(height: 20),
              Text(
                AppStrings.categoryImage,
                style: AppTextStyles.nunitoBold.copyWith(fontSize: 22.sp),
              ),
              const SizedBox(height: 10),
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
                      imageController.imageName != null
                          ? imageController.imageName!
                          : AppStrings.noFileChosen,
                      style: AppTextStyles.nunitoMedium.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              loadingController.isLoading
                  ? const CircularProgressIndicator()
                  : PrimaryButton(
                    title: AppStrings.submit,
                    width: 220.w,
                    height: 90.h,
                    onTap: () async {
                      await CategoryServices.addCategoryToDb(
                        context: context,
                        title: titleController.text,
                        image: imageController.selectedImage!,
                      );
                      navigationController.updateCategoryScreen(null);
                      imageController.clearUploadImage();
                    },
                  ),
            ],
          ),
        ),
      ],
    );
  }
}
