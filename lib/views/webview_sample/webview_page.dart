import 'package:flutter/material.dart';
import 'package:flutter_package_sample/routes/app_routes.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () =>
              Navigator.pushNamed(context, AppRoutes.webViewScreen),
          child: const Text('Launch Web View'),
        ),
      ),
    );
  }
}
