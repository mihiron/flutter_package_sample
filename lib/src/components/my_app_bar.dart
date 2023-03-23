import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyAppBar(
    this.title, {
    this.leading,
    this.actions,
    super.key,
  });
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  factory MyAppBar.withSettingsButton(
    String title, {
    Widget? leading,
    VoidCallback? onSettingsPressed,
  }) {
    return MyAppBar(
      title,
      leading: leading,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: onSettingsPressed ??
              () {
                debugPrint("onPressed settings");
              },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Theme.of(context).primaryColor,
        leading: leading,
        actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
