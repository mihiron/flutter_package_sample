import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_package_sample/main.dart';
import 'package:flutter_package_sample/src/components/my_alert_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerService {
  // カメラの権限の状態を取得
  static Future<PermissionStatus> getCameraPermission() async {
    // カメラの権限の状態を取得
    final cameraPermission = await Permission.camera.status;
    debugPrint("getCameraPermission : $cameraPermission");
    return cameraPermission;
  }

  // カメラの権限をリクエスト
  static Future<PermissionStatus> requestCameraPermission(
      BuildContext context) async {
    // カメラの権限をリクエスト
    final cameraPermission = await Permission.camera.request();
    debugPrint("requestCameraPermission : $cameraPermission");

    // リクエスト結果がgranted(許可)でなければアラートダイアログを表示する
    if (!cameraPermission.isGranted) {
      final String? selectedText = await showDialog<String>(
        context: navigatorKey.currentContext!,
        builder: (_) {
          return const MyAlertDialog(
            title: "AlertDialog",
            content: "カメラへのアクセスを許可してください",
          );
        },
      );

      // アラートダイアログでOKがタップされたらOSの設定画面に遷移
      if (selectedText == "OK") {
        openAppSettings();
      }
    }

    return cameraPermission;
  }

  // カメラから画像を取得
  static Future<File?> getImageFromCamera(BuildContext context) async {
    //　カメラの権限をリクエスト
    final cameraPermission =
        await ImagePickerService.requestCameraPermission(context);

    // リクエスト結果がgranted(許可)でなければ終了
    if (!cameraPermission.isGranted) {
      return null;
    }

    // リクエスト結果がgranted(許可)であればカメラを起動
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile == null) {
      return null;
    }

    return File(pickedFile.path);
  }

  // ギャラリーから画像を取得
  static Future getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return File(pickedFile!.path);
  }
}
