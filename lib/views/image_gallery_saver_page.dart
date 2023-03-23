import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter_package_sample/components/my_app_bar.dart';
import 'package:flutter_package_sample/services/image_picker_service.dart';

final imageStateProvider = StateProvider<File>((ref) {
  return File("");
});

class ImageGallerySaverPage extends ConsumerWidget {
  const ImageGallerySaverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // StateControllerの取得
    final imageStateController = ref.read(imageStateProvider.notifier);

    // watch() またはread() の引数にProviderを指定し、Providerが管理しているデータを取得
    final image = ref.watch(imageStateProvider);

    // 画像の保存
    Future saveImage() async {
      // 空の場合は保存しない
      if (image.path.isEmpty) {
        return;
      }

      // 画像データの配列を取得
      Uint8List buffer = await image.readAsBytes();
      // 保存
      final result = await ImageGallerySaver.saveImage(buffer);

      debugPrint(result.toString());
    }

    return Scaffold(
      appBar: const MyAppBar("ImageGallerySaverPage"),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 200,
            child: image.path.isEmpty
                ? const Center(child: Text('No image selected.'))
                : Image.file(image),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                onPressed: () async {
                  // ImagePickerServiceのgetImageFromCamera()を使い、カメラから画像を取得
                  final picked = await ImagePickerService.getImageFromCamera();
                  // 取得した画像をプロバイダー経由で画面に反映
                  imageStateController.state = picked!;
                },
                heroTag: 'hiro1',
                child: const Icon(Icons.add_a_photo),
              ),
              FloatingActionButton(
                onPressed: () async {
                  // ImagePickerServiceのgetImageFromGallery()を使い、カメラから画像を取得
                  final picked = await ImagePickerService.getImageFromGallery();
                  // 取得した画像をプロバイダー経由で画面に反映
                  imageStateController.state = picked!;
                },
                heroTag: 'hiro2',
                child: const Icon(Icons.image),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                // saveImageで画像を保存
                onPressed: saveImage,
                backgroundColor: Colors.red,
                child: const Icon(Icons.save_alt),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
