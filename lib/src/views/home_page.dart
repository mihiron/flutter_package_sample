import 'package:flutter/material.dart';
import 'package:flutter_package_sample/src/components/my_app_bar.dart';
import 'package:flutter_package_sample/src/routes/app_routes.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = _items(context);
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: MyAppBar.withSettingsButton(
        'Home',
        onSettingsPressed: () => scaffoldKey.currentState!.openEndDrawer(),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => debugPrint('onPressed menu'),
        ),
      ),
      body: ListView.separated(
        itemCount: items.length,
        itemBuilder: (_, index) {
          return items[index];
        },
        separatorBuilder: (_, index) {
          return Container(color: Colors.grey, height: 1.0);
        },
      ),
    );
  }

  List<Widget> _items(BuildContext context) {
    return [
      _myListTile(context, AppRoutes.adaptiveDialog),
      _myListTile(context, AppRoutes.flutterLocalNotifications),
      _myListTile(context, AppRoutes.permissionHandler),
      _myListTile(context, AppRoutes.flutterKeyboardVisibility),
      _myListTile(context, AppRoutes.cachedNetworkImage),
      _myListTile(context, AppRoutes.imageGallerySaver),
      _myListTile(context, AppRoutes.secureStorage),
      _myListTile(context, AppRoutes.dio),
      _myListTile(context, AppRoutes.webView),
    ];
  }

  Widget _myListTile(BuildContext context, String appRoutes) {
    return ListTile(
      leading: const Icon(Icons.star),
      title: Text(
        appRoutes,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () => Navigator.pushNamed(context, appRoutes),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
      ),
    );
  }
}
