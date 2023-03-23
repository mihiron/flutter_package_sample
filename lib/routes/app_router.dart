import 'package:flutter/material.dart';
import 'package:flutter_package_sample/routes/app_routes.dart';
import 'package:flutter_package_sample/views/cached_network_image_page.dart';
import 'package:flutter_package_sample/views/dio_coffee_page.dart';
import 'package:flutter_package_sample/views/flutter_keyboard_visibility_page.dart';
import 'package:flutter_package_sample/views/home_page.dart';
import 'package:flutter_package_sample/views/image_gallery_saver_page.dart';
import 'package:flutter_package_sample/views/secure_storage_page.dart';
import 'package:flutter_package_sample/views/webview_sample/webview_page.dart';
import 'package:flutter_package_sample/views/webview_sample/webview_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return _buildRoute(const MyHomePage());
      case AppRoutes.dioPage:
        return _buildRoute(const DioCoffeePage());
      case AppRoutes.webView:
        return _buildRoute(const WebViewPage());
      case AppRoutes.webViewScreen:
        return _buildRoute(const WebViewScreenPage());
      case AppRoutes.secureStoragePage:
        return _buildRoute(SecureStoragePage());
      case AppRoutes.imageGallerySaverPage:
        return _buildRoute(const ImageGallerySaverPage());
      case AppRoutes.cachedNetworkImagePage:
        return _buildRoute(CachedNetworkImagePage());
      case AppRoutes.flutterKeyboardVisibilityPage:
        return _buildRoute(const FlutterKeyboardVisibilityPage());

      default:
        return null;
    }
  }

  static Route<dynamic>? _buildRoute(
    Widget child, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
  }) {
    return MaterialPageRoute(
      builder: (BuildContext context) => child,
      settings: settings,
      fullscreenDialog: fullscreenDialog,
    );
  }
}
