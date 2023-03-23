import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_package_sample/src/routes/app_router.dart';

// RouteObserverのインスタンス
final RouteObserver<PageRoute> _routeObserver = RouteObserver<PageRoute>();

void main() async {
  // ルートにProviderScopeを追加
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
