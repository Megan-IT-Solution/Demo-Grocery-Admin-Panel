import 'dart:html' as html;
import 'dart:typed_data';

class BannerModel {
  final String? id;
  final Uint8List? localImage;
  final html.File? localFile;
  final String? imageUrl;
  final String? storagePath;

  BannerModel({
    this.id,
    this.localImage,
    this.localFile,
    this.imageUrl,
    this.storagePath,
  });
}
