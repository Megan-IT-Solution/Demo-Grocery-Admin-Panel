import 'package:flutter/cupertino.dart';

import '../constants/firestore_collection.dart';
import '../models/category_model.dart';

class CategoryController extends ChangeNotifier {
  List<CategoryModel> _categoryModel = [];
  List<CategoryModel> get categoryModel => _categoryModel;

  getCategories() {
    FireStoreCollections.categoryCollection.snapshots().listen((snap) {
      _categoryModel =
          snap.docs.map((e) {
            return CategoryModel.fromDoc(e);
          }).toList();
    });
    notifyListeners();
  }
}
