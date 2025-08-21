import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:grocery_admin_panel/services/storage_services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../constants/custom_msgs.dart';
import '../constants/firestore_collection.dart';
import '../controllers/image_controller.dart';
import '../controllers/loading_controller.dart';
import '../models/category_model.dart';

class CategoryServices {
  static addCategoryToDb({
    required BuildContext context,
    required String title,
    Uint8List? image,
  }) async {
    if (title.isEmpty) {
      showCustomMsg(context, "Category title is required");
    } else if (image == null) {
      showCustomMsg(context, "Image is required");
    } else {
      Provider.of<LoadingController>(context, listen: false).setLoading(true);

      try {
        String imageUrl = await StorageServices().uploadPhoto(image);
        String id = const Uuid().v4();
        CategoryModel categoryModel = CategoryModel(
          image: imageUrl,
          id: id,
          title: title,
        );
        await FireStoreCollections.categoryCollection
            .doc(id)
            .set(categoryModel.toMap());

        if (!context.mounted) return;

        Provider.of<LoadingController>(
          context,
          listen: false,
        ).setLoading(false);
      } on FirebaseException catch (e) {
        Provider.of<LoadingController>(
          context,
          listen: false,
        ).setLoading(false);
        showCustomMsg(context, e.message.toString());
      }
    }
  }

  static updateCategory({
    required BuildContext context,
    required String title,
    required String id,
    required String image,
  }) async {
    if (title.isEmpty) {
      showCustomMsg(context, "Category title is required");
    } else {
      Provider.of<LoadingController>(context, listen: false).setLoading(true);

      try {
        String? imageUrl;
        if (Provider.of<ImageController>(
              context,
              listen: false,
            ).selectedImage !=
            null) {
          imageUrl = await StorageServices().uploadPhoto(
            Provider.of<ImageController>(context, listen: false).selectedImage!,
          );
        } else {
          imageUrl = image;
        }
        CategoryModel categoryModel = CategoryModel(
          image: imageUrl,
          id: id,
          title: title,
        );
        await FireStoreCollections.categoryCollection
            .doc(id)
            .update(categoryModel.toMap());

        if (!context.mounted) return;

        Provider.of<LoadingController>(
          context,
          listen: false,
        ).setLoading(false);
      } on FirebaseException catch (e) {
        Provider.of<LoadingController>(
          context,
          listen: false,
        ).setLoading(false);
        showCustomMsg(context, e.message.toString());
      }
    }
  }
}
