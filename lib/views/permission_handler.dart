import 'package:flutter/material.dart';
import 'package:flutter_package_sample/components/my_app_bar.dart';
import 'package:flutter_package_sample/services/image_picker_service.dart';

class PermissionHandlerPage extends StatelessWidget {
  const PermissionHandlerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.withSettingsButton("PermissionHandlerPage"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => ImagePickerService.getCameraPermission(),
              child: const Text(
                "getCameraPermission",
              ),
            ),
            ElevatedButton(
              onPressed: () =>
                  ImagePickerService.requestCameraPermission(context),
              child: const Text(
                "requestCameraPermission",
              ),
            ),
            ElevatedButton(
              onPressed: () async =>
                  await ImagePickerService.getImageFromCamera(context),
              child: const Text(
                "カメラ起動",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
