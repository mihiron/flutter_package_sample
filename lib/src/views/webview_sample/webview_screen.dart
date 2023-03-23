import 'package:flutter/material.dart';
import 'package:flutter_package_sample/src/components/my_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreenPage extends StatelessWidget {
  const WebViewScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    late final WebViewController controller;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));

    return Scaffold(
      appBar: const MyAppBar('WebViewPage'),
      body: Center(
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
