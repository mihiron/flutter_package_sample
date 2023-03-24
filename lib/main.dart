import 'package:flutter/material.dart';
import 'package:flutter_package_sample/src/utils/push_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_package_sample/src/routes/app_router.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// RouteObserverのインスタンス
final RouteObserver<PageRoute> _routeObserver = RouteObserver<PageRoute>();
// グローバルキーの設定
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // ルートにProviderScopeを追加
  runApp(const ProviderScope(child: MyApp()));

  // PushManager初期化
  PushManager.instance.initializePlatformSpecifics();
  // タイムゾーンデータベースの初期化
  tz.initializeTimeZones();
  // ローカルロケーションのタイムゾーンを東京に設定
  tz.setLocalLocation(tz.getLocation("Asia/Tokyo"));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      // RouteObserverのインスタンスをNavigatorObserverのリストに渡す
      navigatorObservers: [_routeObserver],
      // onGenerateRouteを設定
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
