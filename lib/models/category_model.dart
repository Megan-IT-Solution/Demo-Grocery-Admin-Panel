import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String? id;
  final String? image;
  final String? title;
  final DateTime? createdAt;
  CategoryModel({this.id, this.image, this.title, this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "image": image,
      "title": title,
      'createdAt': DateTime.now(),
    };
  }

  factory CategoryModel.fromDoc(DocumentSnapshot snap) {
    return CategoryModel(
      id: snap["id"],
      image: snap["image"],
      title: snap["title"],
      createdAt: (snap['createdAt'] as Timestamp).toDate(),
    );
  }
}
