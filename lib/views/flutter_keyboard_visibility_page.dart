import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_package_sample/components/my_app_bar.dart';

class FlutterKeyboardVisibilityPage extends StatefulWidget {
  const FlutterKeyboardVisibilityPage({super.key});

  @override
  State<FlutterKeyboardVisibilityPage> createState() =>
      _FlutterKeyboardVisibilityPageState();
}

class _FlutterKeyboardVisibilityPageState
    extends State<FlutterKeyboardVisibilityPage> {
  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    super.initState();
    debugPrint("===initState===");
    var keyboardVisibilityController = KeyboardVisibilityController();
    // 直接クエリとサブスクリプション
    // Query
    debugPrint(
        'Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');
    // Subscribe
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      debugPrint('Keyboard visibility update. Is visible: $visible');
    });
  }

  @override
  void dispose() {
    debugPrint("===dispose===");
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar("FlutterKeyboardVisibilityPage"),
      // タップ時にキーボードを閉じる
      body: KeyboardDismissOnTap(
        dismissOnCapturedTaps: true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Widgetビルダーを使用してキーボードの可視性の変更に対応
              KeyboardVisibilityBuilder(
                builder: (context, isKeyboardVisible) {
                  return Text(
                      'The keyboard is: ${isKeyboardVisible ? 'VISIBLE' : 'NOT VISIBLE'}');
                },
              ),
              // Widgetプロバイダーを使用してキーボードの可視性の変更に対応
              KeyboardVisibilityProvider(
                child: Builder(
                  builder: (BuildContext context) {
                    final bool isKeyboardVisible =
                        KeyboardVisibilityProvider.isKeyboardVisible(context);

                    return Text(
                        'The keyboard is: ${isKeyboardVisible ? 'VISIBLE' : 'NOT VISIBLE'}');
                  },
                ),
              ),
              const SizedBox(
                width: 200,
                child: TextField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
