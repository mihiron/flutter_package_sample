import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_package_sample/src/components/my_app_bar.dart';
import 'package:flutter_package_sample/src/routes/app_routes.dart';
import 'package:flutter_package_sample/src/views/webview_sample/flutter_in_app_web_view/in_app_browser.dart';
import 'package:flutter_package_sample/src/views/webview_sample/flutter_in_app_web_view/chrome_safari_browser.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MyInAppBrowser myInAppBrowser = MyInAppBrowser();
    final MyChromeSafariBrowser myChromeSafariBrowser = MyChromeSafariBrowser();

    return Scaffold(
      appBar: const MyAppBar("WebViewPage"),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.webViewScreen),
              child: const Text("Open WebView"),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.inAppWebViewScreen),
              child: const Text("Open InAppWebView"),
            ),
            ElevatedButton(
              onPressed: () async => await myInAppBrowser.openUrlRequest(
                urlRequest: URLRequest(
                  url: Uri.parse("https://flutter.dev"),
                ),
                options: InAppBrowserClassOptions(
                  crossPlatform: InAppBrowserOptions(hideUrlBar: false),
                  inAppWebViewGroupOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(javaScriptEnabled: true),
                  ),
                ),
              ),
              child: const Text("Open InAppBrowser"),
            ),
            ElevatedButton(
              onPressed: () async => await myChromeSafariBrowser.open(
                url: Uri.parse("https://flutter.dev/"),
                options: ChromeSafariBrowserClassOptions(
                  android: AndroidChromeCustomTabsOptions(
                      shareState: CustomTabsShareState.SHARE_STATE_OFF),
                  ios: IOSSafariOptions(barCollapsingEnabled: true),
                ),
              ),
              child: const Text("Open ChromeSafariBrowser"),
            ),
          ],
        ),
      ),
    );
  }
}
