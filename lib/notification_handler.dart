import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  static final flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();
  static BuildContext? myContext;

  static void initNotification() async {
    var initAndroid = const AndroidInitializationSettings("mipmap/ic_launcher");

    var settingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: null);

    var initializationSettings =
        InitializationSettings(iOS: settingsIOS, android: initAndroid);

    flutterLocalNotificationPlugin.initialize(initializationSettings,
        onSelectNotification: null);
  }

  static Future onSelectNotification(String payload) async {
    if (payload != null) print("Get Payload: $payload");
  }

  static Future onDidReceiveLocalNotification(
    String title,
    String body,
    String payload,
  ) async {
    showDialog(
        context: myContext!,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: [
                CupertinoDialogAction(
                  child: const Text("Ok"),
                  isDefaultAction: true,
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                )
              ],
            ));
  }
}
