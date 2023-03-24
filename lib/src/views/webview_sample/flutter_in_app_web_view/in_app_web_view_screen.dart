import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_package_sample/src/components/my_app_bar.dart';

class InAppWebViewScreenPage extends StatelessWidget {
  const InAppWebViewScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar("InAppWebViewScreenPage"),
      body: Center(
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse("https://flutter.dev")),
          // オプション
          initialOptions: InAppWebViewGroupOptions(
            // 共通のオプション
            crossPlatform: InAppWebViewOptions(
              horizontalScrollBarEnabled: false,
              verticalScrollBarEnabled: false,
            ),
            // iOSのオプション
            ios: IOSInAppWebViewOptions(
              sharedCookiesEnabled: true,
            ),
            // Androidのオプション
            android: AndroidInAppWebViewOptions(
              thirdPartyCookiesEnabled: true,
            ),
          ),
          onWebViewCreated: (InAppWebViewController controller) async {
            // ページ生成後に処理される関数
            // ページ生成後のオブジェクトを取得可能
            Favicon faviconUrl = await getFavicon(controller);
            debugPrint("faviconUrl.url: ${faviconUrl.url.toString()}");
          },
        ),
      ),
    );
  }

  // 表示サイトのfaviconを取得する関数
  Future<Favicon> getFavicon(InAppWebViewController controller) async {
    List<Favicon> favicon;
    favicon = await controller.getFavicons();
    return favicon[0];
  }
}
