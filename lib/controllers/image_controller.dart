import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ImageController extends ChangeNotifier {
  Uint8List? _selectedImage;
  String? _imageName;

  Uint8List? get selectedImage => _selectedImage;
  String? get imageName => _imageName;

  final String _removeBgApiKey = "Shuhm8EiBPKucn71dJtK5JNd";

  Future<void> uploadImage(ImageSource source) async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      _imageName = path.basename(pickedImage.path);
      Uint8List originalBytes = await pickedImage.readAsBytes();
      await _removeBackground(originalBytes);
    }
  }

  Future<void> _removeBackground(Uint8List imageBytes) async {
    try {
      final uri = Uri.parse("https://api.remove.bg/v1.0/removebg");

      final request =
          http.MultipartRequest('POST', uri)
            ..headers['X-Api-Key'] = _removeBgApiKey
            ..fields['size'] = 'auto'
            ..files.add(
              http.MultipartFile.fromBytes(
                'image_file',
                imageBytes,
                filename: _imageName ?? 'image.png',
              ),
            );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        _selectedImage = response.bodyBytes;
        notifyListeners();
      } else {
        if (kDebugMode) {
          print("❌ Background removal failed: ${response.statusCode}");
        }
        if (kDebugMode) {
          print("Response body: ${response.body}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Error during background removal: $e");
      }
    }
  }

  void clearUploadImage() {
    _selectedImage = null;
    _imageName = null;
    notifyListeners();
  }
}
