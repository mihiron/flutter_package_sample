import 'package:flutter/material.dart';
import 'package:flutter_package_sample/routes/app_routes.dart';
import 'package:flutter_package_sample/views/dio_coffee_page.dart';
import 'package:flutter_package_sample/views/home_page.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return _buildRoute(const MyHomePage());
      case AppRoutes.dioPage:
        return _buildRoute(const DioCoffeePage());

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
