import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../controllers/image_controller.dart';
import '../../../../controllers/loading_controller.dart';
import '../../../../models/product_model.dart';
import '../../../../services/product_services.dart';
import '../../../../utils/lists.dart';
import '../../../../widgets/buttons.dart';
import '../../../../widgets/text_inputs.dart';
import 'dropdown_widget_add_product_screen.dart';

class UpdateProductForm extends StatefulWidget {
  final ProductModel product;

  const UpdateProductForm({super.key, required this.product});

  @override
  State<UpdateProductForm> createState() => _UpdateProductFormState();
}

class _UpdateProductFormState extends State<UpdateProductForm> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;

  String? _selectedUnit;
  String? _selectedTaxCategory;
  String? _selectedCategory;

  late List<TextEditingController> _quantityLabelControllers;
  late List<TextEditingController> _quantityPriceControllers;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.product.pdtName);
    _descriptionController = TextEditingController(
      text: widget.product.description,
    );
    _priceController = TextEditingController(
      text: widget.product.pdtPrice.toString(),
    );
    _quantityController = TextEditingController(
      text: widget.product.totalStock.toString(),
    );

    _selectedTaxCategory = widget.product.taxCategory;
    _selectedCategory = widget.product.category;

    _quantityLabelControllers = [];
    _quantityPriceControllers = [];

    if (widget.product.quantities.isNotEmpty) {
      for (final quantity in widget.product.quantities) {
        _quantityLabelControllers.add(
          TextEditingController(text: quantity.label),
        );
        _quantityPriceControllers.add(
          TextEditingController(text: quantity.price.toString()),
        );
      }
    } else {
      _quantityLabelControllers.add(TextEditingController());
      _quantityPriceControllers.add(TextEditingController());
    }

    Provider.of<ImageController>(context, listen: false).clearUploadImage();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();

    for (var controller in _quantityLabelControllers) {
      controller.dispose();
    }
    for (var controller in _quantityPriceControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageController = Provider.of<ImageController>(context);
    final loadingController = Provider.of<LoadingController>(context);

    return AlertDialog(
      title: const Text('Update Product'),
      content: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => imageController.uploadImage(ImageSource.gallery),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        imageController.selectedImage != null
                            ? MemoryImage(imageController.selectedImage!)
                            : NetworkImage(widget.product.pdtImage)
                                as ImageProvider,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.white70,
                        radius: 18,
                        child: Icon(Icons.camera_alt, color: Colors.grey[800]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Product Name",
                  style: AppTextStyles.quicksandBold.copyWith(fontSize: 12),
                ),
                SizedBox(height: 3),
                CustomTextInput(controller: _nameController),
                SizedBox(height: 10),
                Text(
                  "Product Description",
                  style: AppTextStyles.quicksandBold.copyWith(fontSize: 12),
                ),
                SizedBox(height: 3),
                CustomTextInput(controller: _descriptionController),
                const SizedBox(height: 10),
                Text(
                  "Actual Price",
                  style: AppTextStyles.quicksandBold.copyWith(fontSize: 12),
                ),
                SizedBox(height: 3),
                CustomTextInput(
                  controller: _priceController,
                  inputType: TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                Text(
                  "Total Stock",
                  style: AppTextStyles.quicksandBold.copyWith(fontSize: 12),
                ),
                SizedBox(height: 3),
                CustomTextInput(
                  controller: _quantityController,
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                Text(
                  "Tax Category",
                  style: AppTextStyles.quicksandBold.copyWith(fontSize: 12),
                ),
                SizedBox(height: 3),
                DropDownWidgetAddProductScreen(
                  dropDownValue: _selectedTaxCategory,
                  dropDownList: taxCategoryList,
                  hintText: _selectedTaxCategory,
                  onChanged:
                      loadingController.isLoading
                          ? null
                          : (val) => setState(() => _selectedTaxCategory = val),
                ),
                const SizedBox(height: 10),
                Text(
                  "Product Category",
                  style: AppTextStyles.quicksandBold.copyWith(fontSize: 12),
                ),
                SizedBox(height: 3),
                StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance
                          .collection('categories')
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final categories =
                        snapshot.data!.docs
                            .map((doc) => doc['title'].toString())
                            .toList();

                    return DropDownWidgetAddProductScreen(
                      hintText: _selectedCategory ?? "Select Category",
                      dropDownValue: _selectedCategory,
                      dropDownList: categories,
                      onChanged:
                          loadingController.isLoading
                              ? null
                              : (val) =>
                                  setState(() => _selectedCategory = val),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Quantity Options (Label & Price)",
                    style: AppTextStyles.quicksandBold.copyWith(fontSize: 12),
                  ),
                ),
                SizedBox(height: 10.h),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 150.h),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        _quantityLabelControllers.length,
                        (index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: CustomTextInput(
                                    controller:
                                        _quantityLabelControllers[index],
                                    hintText: "Label (e.g. 250g)",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  flex: 2,
                                  child: CustomTextInput(
                                    controller:
                                        _quantityPriceControllers[index],
                                    hintText: "Price",
                                    inputType: TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                IconButton(
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    if (_quantityLabelControllers.length > 1) {
                                      setState(() {
                                        _quantityLabelControllers.removeAt(
                                          index,
                                        );
                                        _quantityPriceControllers.removeAt(
                                          index,
                                        );
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text("Add Quantity Option"),
                    onPressed: () {
                      setState(() {
                        _quantityLabelControllers.add(TextEditingController());
                        _quantityPriceControllers.add(TextEditingController());
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          if (loadingController.isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black38,
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
      actions: [
        SecondaryButton(
          width: 150.w,
          onPressed:
              loadingController.isLoading
                  ? null
                  : () => Navigator.of(context, rootNavigator: true).pop(),
          title: "Cancel",
          btnColor: AppColors.primaryWarning,
        ),
        SecondaryButton(
          width: 150.w,
          onPressed:
              loadingController.isLoading
                  ? null
                  : () async {
                    final imageController = Provider.of<ImageController>(
                      context,
                      listen: false,
                    );
                    final loadingController = Provider.of<LoadingController>(
                      context,
                      listen: false,
                    );

                    List<QuantityOption> quantities = [];
                    for (int i = 0; i < _quantityLabelControllers.length; i++) {
                      final label = _quantityLabelControllers[i].text.trim();
                      final priceText =
                          _quantityPriceControllers[i].text.trim();

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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please add at least one quantity option with valid label and price",
                          ),
                        ),
                      );
                      return;
                    }

                    try {
                      loadingController.setLoading(true);

                      await ProductServices().updateProduct(
                        context: context,
                        pdtId: widget.product.pdtId,
                        productName:
                            _nameController.text.trim().isEmpty
                                ? widget.product.pdtName
                                : _nameController.text.trim(),
                        description:
                            _descriptionController.text.trim().isEmpty
                                ? widget.product.description
                                : _descriptionController.text.trim(),
                        price:
                            double.tryParse(_priceController.text.trim()) ??
                            widget.product.pdtPrice,
                        quantity:
                            int.tryParse(_quantityController.text.trim()) ??
                            widget.product.totalStock,
                        taxCategory:
                            _selectedTaxCategory ?? widget.product.taxCategory,
                        category: _selectedCategory ?? widget.product.category,
                        oldImageUrl: widget.product.pdtImage,
                        image: imageController.selectedImage,
                        quantities: quantities,
                      );

                      if (!mounted) return;
                      // Navigator.of(context, rootNavigator: true).pop();
                    } catch (e) {
                      if (kDebugMode) {
                        print("Update failed: $e");
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Update failed: $e")),
                      );
                    } finally {
                      loadingController.setLoading(false);
                    }
                  },
          title: "Update",
          btnColor: AppColors.primaryColor,
        ),
      ],
    );
  }
}
