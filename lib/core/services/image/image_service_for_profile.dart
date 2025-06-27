
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();
  final SharedPreferences _prefs;

  ImageService(this._prefs);

  Future<File?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  Future<void> saveImagePath(String path) async {
    await _prefs.setString('lastImagePath', path);
  }

  Future<String?> getLastImagePath() async {
    return _prefs.getString('lastImagePath');
  }

  Future<void> clearImageCache() async {
    await _prefs.remove('lastImagePath');
  }
}