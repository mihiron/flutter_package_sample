import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_package_sample/src/components/my_app_bar.dart';

class AdaptiveDialogPage extends StatelessWidget {
  const AdaptiveDialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = _items(context);

    return Scaffold(
      appBar: const MyAppBar("AdaptiveDialogPage"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items,
        ),
      ),
    );
  }

  List<Widget> _items(BuildContext context) {
    return [
      _myElevatedButton(
        context,
        "showConfirmationDialog",
        onPressed: () async {
          final result = await showConfirmationDialog(
            context: context,
            title: "showConfirmationDialog",
            message: "メッセージメッセージ",
            okLabel: "OK",
            cancelLabel: "Cancel",
            initialSelectedActionKey: "key3",
            actions: [
              const AlertDialogAction(
                  key: "key1", label: "１項目目", isDestructiveAction: true),
              const AlertDialogAction(
                  key: "key2", label: "２項目目", isDefaultAction: true),
              const AlertDialogAction(key: "key3", label: "３項目目"),
            ],
          );
          debugPrint(result.toString());
        },
      ),
      _myElevatedButton(
        context,
        "showOkCancelAlertDialog",
        onPressed: () async {
          final OkCancelResult result = await showOkCancelAlertDialog(
            context: context,
            title: "showOkCancelAlertDialog",
            message: "メッセージメッセージ",
          );
          debugPrint(result.toString());
        },
      ),
    ];
  }

  Widget _myElevatedButton(
    BuildContext context,
    String text, {
    VoidCallback? onPressed,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromWidth(100),
            backgroundColor: Colors.blueGrey,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        ),
      ),
      child: Container(
        height: 30,
        margin: const EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: onPressed ??
              () {
                debugPrint("onPressed");
              },
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black54,
              // fontSize: 16.0,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
