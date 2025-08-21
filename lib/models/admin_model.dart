import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  final String? id;
  final String? username;
  final String? image;
  final String? email;

  AdminModel({this.id, this.username, this.image, this.email});

  Map<String, dynamic> toMap() {
    return {"id": id, "userName": username, "image": image, "email": email};
  }

  factory AdminModel.fromDoc(DocumentSnapshot snap) {
    return AdminModel(
      id: snap["id"],
      username: snap["userName"],
      image: snap["image"],
      email: snap["email"],
    );
  }
}
