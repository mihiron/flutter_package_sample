import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  // カメラから画像を取得
  static Future<File?> getImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    return File(pickedFile!.path);
  }

  // ギャラリーから画像を取得
  static Future getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return File(pickedFile!.path);
  }
}
