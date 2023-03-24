import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyInAppBrowser extends InAppBrowser {
  @override
  Future onBrowserCreated() async {
    debugPrint("\n\nBrowser Created!\n\n");
  }

  @override
  Future onLoadStart(url) async {
    debugPrint("\n\nStarted $url\n\n");
  }

  @override
  Future onLoadStop(url) async {
    debugPrint("\n\nStopped $url\n\n");
  }

  @override
  void onLoadError(url, code, message) {
    debugPrint("Can't load $url.. Error: $message");
  }

  @override
  void onProgressChanged(progress) {
    debugPrint("Progress: $progress");
  }

  @override
  void onExit() {
    debugPrint("\n\nBrowser closed!\n\n");
  }

  @override
  void onLoadResource(resource) {
    debugPrint(
        "Started at: ${resource.startTime}ms ---> duration: ${resource.duration}ms ${resource.url}");
  }

  @override
  void onConsoleMessage(ConsoleMessage consoleMessage) {
    debugPrint("""
    console output:
      message: ${consoleMessage.message}
      messageLevel: ${consoleMessage.messageLevel.toValue()}
   """);
  }
}
