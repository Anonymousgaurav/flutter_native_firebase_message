import 'dart:io';
import 'dart:math';

import 'package:firebase_cloud_messaging/notification_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotification {
  FirebaseMessaging? firebaseMessaging;
  BuildContext? context;

  void setUpFirebase(BuildContext context) {
    firebaseMessaging = FirebaseMessaging.instance;
    NotificationHandler.initNotification();
    firebaseCloudMessagingListener(context);
    context = context;
  }

  void firebaseCloudMessagingListener(BuildContext Context) async {
    NotificationSettings setting = await firebaseMessaging!.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: false,
        provisional: false,
        sound: true);
    print('Settings ${setting.authorizationStatus}');

    //Get Token then we will use token to receive notification
    firebaseMessaging?.getToken().then((token) => print('MyToeknn${token}'));

    // subscribe to topic
    // we will send to topic for group notification

    firebaseMessaging
        ?.subscribeToTopic("gaurav_demo")
        .whenComplete(() => print("Subscription Done"));

    //Handle Message
    FirebaseMessaging.onMessage.listen((remoteMessage) {
      print('Receive Message $remoteMessage');
      if (Platform.isAndroid) {
        showNotification(remoteMessage.notification?.title,
            remoteMessage.notification?.title);
      } else {
        showNotification(remoteMessage.notification?.title,
            remoteMessage.notification?.body);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      print('Receive open app : ${remoteMessage}');

      if (Platform.isIOS) {
        showDialog(
            context: context!,
            builder: (context) => CupertinoAlertDialog(
                  title: Text(remoteMessage.notification!.title!),
                  content: Text(remoteMessage.notification!.body!),
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
    });
  }

  static void showNotification(title, body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
            "com.gaurav.firebase_cloud_messaging", "My Channel",
            channelDescription: "This is for only demo purpose",
            autoCancel: true,
            ongoing: true,
            importance: Importance.max,
            priority: Priority.high);

    IOSNotificationDetails iosNotificationDetails =
        const IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    await NotificationHandler.flutterLocalNotificationPlugin.show(
        Random().nextInt(1000), title, body, notificationDetails,
        payload: "My Payload");
  }
}

abstract class Constants {
  static final String NOTIFICATION = "notification";

  static final String APS = "aps";
  static final String ALERT = "alert";

  static final String TITLE = "title";
  static final String BODY = "body";
}
