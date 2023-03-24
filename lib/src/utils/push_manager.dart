import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

class PushManager {
  PushManager._();
  static final _instance = PushManager._();
  static PushManager get instance => _instance;

  final FlutterLocalNotificationsPlugin _flnp =
      FlutterLocalNotificationsPlugin();

  // 通知権限のリクエスト
  Future<bool> requestPermissions() async {
    // Androidの場合、trueを返却
    if (Platform.isAndroid) {
      debugPrint("isAndroid result:true");
      return true;
    }

    // iOSの場合、パーミッション取得ダイアログを表示
    final result = await _flnp
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            ) ??
        false;

    debugPrint("isIOS result:$result");
    return result;
  }

  // 初期化など
  void initializePlatformSpecifics() {
    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // your call back to the UI
      },
    );

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    _flnp.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse res) {
      debugPrint('payload:${res.payload}');
    });
  }

  // ローカル通知を単純に表示
  Future<void> showNotification() async {
    var androidChannelSpecifics = const AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      channelDescription: "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );

    var iosChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iosChannelSpecifics);

    await _flnp.show(
      0, // Notification ID
      'Test Title', // Notification Title
      'Test Body', // Notification Body, set as null to remove the body
      platformChannelSpecifics,
      payload: 'New Payload', // Notification Payload
    );
  }

  // ローカル通知を指定日時に表示
  Future<void> scheduleNotification() async {
    // 5秒後
    var scheduleNotificationDateTime = DateTime(2023, 3, 24, 12, 55);
    // var scheduleNotificationDateTime = DateTime.now().add(const Duration(seconds: 5));
    debugPrint(scheduleNotificationDateTime.toString());

    var androidChannelSpecifics = const AndroidNotificationDetails(
      'CHANNEL_ID 1',
      'CHANNEL_NAME 1',
      channelDescription: "CHANNEL_DESCRIPTION 1",
      // icon: 'app_icon',
      //sound: RawResourceAndroidNotificationSound('my_sound'),
      // largeIcon: DrawableResourceAndroidBitmap('app_icon'),
      enableLights: true,
      color: Color.fromARGB(255, 255, 0, 0),
      ledColor: Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500,
      importance: Importance.max,
      priority: Priority.high,
      playSound: false,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );

    var iosChannelSpecifics = const DarwinNotificationDetails(
        //sound: 'my_sound.aiff',
        );

    var platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics,
      iOS: iosChannelSpecifics,
    );

    await _flnp.zonedSchedule(
      0,
      'Test Title',
      'Test Body',
      TZDateTime.from(scheduleNotificationDateTime, local),
      platformChannelSpecifics,
      payload: 'Test Payload',
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // 予約済みのローカル通知の数を取得する
  Future<int> getPendingNotificationCount() async {
    List<PendingNotificationRequest> p =
        await _flnp.pendingNotificationRequests();
    return p.length;
  }

  // 通知をキャンセル
  Future<void> cancelNotification() async {
    await _flnp.cancel(0);
  }

  // 通知を全件キャンセル
  Future<void> cancelAllNotification() async {
    await _flnp.cancelAll();
  }
}
