import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_admin_panel/services/storage_services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../constants/custom_msgs.dart';
import '../controllers/loading_controller.dart';
import '../models/product_model.dart';

class ProductServices {
  Future<void> addProduct({
    required BuildContext context,
    required String productName,
    required String description,
    double? price,

    String? taxCategory,
    String? category,
    int? totalStock,
    Uint8List? image,
    List<QuantityOption>? quantities,
  }) async {
    if (productName.isEmpty) {
      showCustomMsg(context, "Product Name required");
      return;
    }
    if (description.isEmpty) {
      showCustomMsg(context, "Description needed");
      return;
    }

    if (price == null) {
      showCustomMsg(context, "Product Price required");
      return;
    }

    if (taxCategory == null || taxCategory.isEmpty) {
      showCustomMsg(context, "Tax Category required");
      return;
    }
    if (category == null || category.isEmpty) {
      showCustomMsg(context, "Product Category required");
      return;
    }
    if (totalStock == null) {
      showCustomMsg(context, "Quantity required");
      return;
    }
    if (image == null) {
      showCustomMsg(context, "Product Image required");
      return;
    }

    final loadingController = Provider.of<LoadingController>(
      context,
      listen: false,
    );

    try {
      loadingController.setLoading(true);

      String pdtId = const Uuid().v4();

      String imageUrl = await StorageServices().uploadPhoto(image);

      ProductModel pdtModel = ProductModel(
        pdtId: pdtId,
        pdtName: productName,
        description: description,
        pdtPrice: price,
        category: category,
        totalStock: totalStock,
        pdtImage: imageUrl,
        taxCategory: taxCategory,
        status: "Available",
        createdAt: DateTime.now(),
        quantities: quantities ?? [],
      );

      await FirebaseFirestore.instance
          .collection('products')
          .doc(pdtId)
          .set(pdtModel.toMap());

      if (!context.mounted) return;

      showCustomMsg(context, "Product Added Successfully");
      Get.offAllNamed('/sideBarScreen');
    } catch (e) {
      showCustomMsg(context, "Failed to add product: $e");
    } finally {
      loadingController.setLoading(false);
    }
  }

  Future<void> deleteProductFromDB(BuildContext context, String pdtId) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(pdtId)
          .delete();
      if (!context.mounted) return;
      showCustomMsg(context, "Product Deleted Successfully");
    } on FirebaseException catch (e) {
      showCustomMsg(context, e.message!);
    }
  }

  Future<void> updateProduct({
    required BuildContext context,
    required String pdtId,
    required String productName,
    required String description,
    double? price,
    double? salePrice,
    String? unit,
    String? taxCategory,
    String? category,
    int? quantity,
    Uint8List? image,
    required String oldImageUrl,
    required List<QuantityOption> quantities,
  }) async {
    try {
      String imageUrl = oldImageUrl;

      if (image != null) {
        imageUrl = await StorageServices().uploadPhoto(image);
      }

      ProductModel updated = ProductModel(
        pdtId: pdtId,
        pdtName: productName,
        description: description,
        pdtPrice: price ?? 0,
        // salePrice: salePrice ?? 0,
        // unit: unit ?? "",
        taxCategory: taxCategory ?? "",
        category: category ?? "",
        totalStock: quantity ?? 0,
        pdtImage: imageUrl,
        status: "Available",
        createdAt: DateTime.now(),
        quantities: quantities,
      );

      await FirebaseFirestore.instance
          .collection('products')
          .doc(pdtId)
          .update(updated.toMap());

      if (!context.mounted) return;

      showCustomMsg(context, "Product updated successfully");
      Get.back();
    } catch (e) {
      showCustomMsg(context, "Error updating product: $e");
    }
  }
}
