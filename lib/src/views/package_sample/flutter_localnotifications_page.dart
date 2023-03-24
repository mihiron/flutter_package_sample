import 'package:flutter/material.dart';
import 'package:flutter_package_sample/src/components/my_app_bar.dart';
import 'package:flutter_package_sample/src/utils/push_manager.dart';

// Androidのみ対応

class FlutterLocalNotificationsPage extends StatelessWidget {
  FlutterLocalNotificationsPage({super.key});

  final pushManager = PushManager.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.withSettingsButton("FlutterLocalNotificationsPage"),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => pushManager.requestPermissions(),
              child: const Text(
                "requestPermissions",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                pushManager.showNotification();
              },
              child: const Text(
                "showNotification",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                pushManager.scheduleNotification();
              },
              child: const Text(
                "scheduleNotification",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                pushManager.getPendingNotificationCount().then((value) =>
                    debugPrint('getPendingNotificationCount:$value'));
              },
              child: const Text(
                "getPendingNotificationCount",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                pushManager.cancelNotification();
              },
              child: const Text(
                "cancelNotification",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                pushManager.cancelAllNotification();
              },
              child: const Text(
                "cancelAllNotification",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
