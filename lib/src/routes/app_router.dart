import 'package:flutter/material.dart';
import 'package:flutter_package_sample/src/routes/app_routes.dart';
import 'package:flutter_package_sample/src/views/home_page.dart';
import 'package:flutter_package_sample/src/views/package_sample/adaptive_dialog.dart';
import 'package:flutter_package_sample/src/views/package_sample/cached_network_image_page.dart';
import 'package:flutter_package_sample/src/views/package_sample/dio_coffee_page.dart';
import 'package:flutter_package_sample/src/views/package_sample/flutter_keyboard_visibility_page.dart';
import 'package:flutter_package_sample/src/views/package_sample/flutter_localnotifications_page.dart';
import 'package:flutter_package_sample/src/views/package_sample/image_gallery_saver_page.dart';
import 'package:flutter_package_sample/src/views/package_sample/permission_handler.dart';
import 'package:flutter_package_sample/src/views/package_sample/secure_storage_page.dart';
import 'package:flutter_package_sample/src/views/webview_sample/webview_page.dart';
import 'package:flutter_package_sample/src/views/webview_sample/webview_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return _buildRoute(const MyHomePage());
      case AppRoutes.dio:
        return _buildRoute(const DioCoffeePage());
      case AppRoutes.webView:
        return _buildRoute(const WebViewPage());
      case AppRoutes.webViewScreen:
        return _buildRoute(const WebViewScreenPage());
      case AppRoutes.secureStorage:
        return _buildRoute(SecureStoragePage());
      case AppRoutes.imageGallerySaver:
        return _buildRoute(const ImageGallerySaverPage());
      case AppRoutes.cachedNetworkImage:
        return _buildRoute(CachedNetworkImagePage());
      case AppRoutes.flutterKeyboardVisibility:
        return _buildRoute(const FlutterKeyboardVisibilityPage());
      case AppRoutes.permissionHandler:
        return _buildRoute(const PermissionHandlerPage());
      case AppRoutes.flutterLocalNotifications:
        return _buildRoute(FlutterLocalNotificationsPage());
      case AppRoutes.adaptiveDialog:
        return _buildRoute(const AdaptiveDialogPage());

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
