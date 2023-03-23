import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_package_sample/src/components/my_app_bar.dart';
import 'package:flutter_package_sample/src/services/secure_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 画面表示用のProviderの定義
final textValueProvider = FutureProvider<String?>((ref) async {
  // SecureStorageの読み込み
  final textValue = await SecureStorageService.readStorage("key1") ?? "未入力";
  return textValue;
});

class SecureStoragePage extends ConsumerWidget {
  SecureStoragePage({super.key});

  // TextFieldのコントローラー
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textValue = ref.watch(textValueProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const MyAppBar("SecureStoragePage"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // when()で非同期処理の状態に応じたウィジェットを返す
            textValue.when(
              // エラー時
              error: (err, _) => Text(err.toString()),
              // 読み込み時
              loading: () => const CircularProgressIndicator(),
              // データ受け取り時
              data: (data) => Text(
                data.toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.blue),
              ),
            ),
            SizedBox(
              width: 200,
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: "入力してください"),
                controller: textEditingController,
                enabled: true,
                maxLength: 20,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    // キーボードを閉じる
                    FocusScope.of(context).unfocus();
                    // TextFieldの入力値を取得
                    String textValue = textEditingController.text;

                    // SecureStorageの書き込み
                    await SecureStorageService.writeStorage("key1", textValue);

                    // 画面表示用のプロバイダーを更新
                    ref.refresh(textValueProvider);
                    textEditingController.clear();
                  },
                  child: const Text("保存"),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async {
                    // キーボードを閉じる
                    FocusScope.of(context).unfocus();
                    // SecureStorageの読み込み
                    final textValue =
                        await SecureStorageService.readStorage("key1") ?? "未入力";
                    debugPrint(textValue);
                  },
                  child: const Text("読込み"),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    // キーボードを閉じる
                    FocusScope.of(context).unfocus();
                    // SecureStorageの削除
                    await SecureStorageService.deleteStorage("key1");
                    // 画面表示用のプロバイダーを更新
                    ref.refresh(textValueProvider);
                  },
                  child: const Text("削除"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async {
                    // キーボードを閉じる
                    FocusScope.of(context).unfocus();
                    // SecureStorageの全件読み込み
                    final textValue =
                        await SecureStorageService.readAllStorage();
                    debugPrint(textValue.toString());
                  },
                  child: const Text("読込みALL"),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    // キーボードを閉じる
                    FocusScope.of(context).unfocus();
                    // SecureStorageの全件削除
                    await SecureStorageService.deleteAllStorage();
                    // 画面表示用のプロバイダーを更新
                    ref.refresh(textValueProvider);
                  },
                  child: const Text("削除ALL"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
