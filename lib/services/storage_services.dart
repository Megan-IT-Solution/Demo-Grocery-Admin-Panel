import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  Future<String> uploadPhoto(Uint8List image) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference = storage.ref().child(
        'products/${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      TaskSnapshot uploadTaskSnapshot = await reference.putData(image);

      String url = await uploadTaskSnapshot.ref.getDownloadURL();

      return url;
    } catch (e, stackTrace) {
      rethrow;
    }
  }

  String getImageNameFromFirebaseURL(String url) {
    Uri uri = Uri.parse(url);
    String path = uri.path;
    List<String> pathParts = path.split('/');
    String imageNameWithParams = pathParts.last;
    String imageName = imageNameWithParams.split('?').first;
    return imageName;
  }
}
