import 'dart:convert';

import 'package:birthdates/managers/preference_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  // print(message.notification?.title);
}

class FirebaseNotification {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final preference = PreferenceManager();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.defaultImportance,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initLocalNotifications() async {
    const iOS = IOSInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const setting = InitializationSettings(
      android: android,
      iOS: iOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      setting,
      onSelectNotification: (payload) {
        // final message = RemoteMessage.fromMap(jsonDecode(payload!));
        // handleMessage(message);
      },
      // onDidReceiveNotificationResponse: (details) {
      //   final message = RemoteMessage.fromMap(jsonDecode(details));
      // },
    );

    final platform =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(channel);
  }

  Future<void> initNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await _firebaseMessaging.requestPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    // final fcmToken = preference.getDeviceToken;
    // print(fcmToken);

    /// get notification when app is in background state
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    /// get notification when app is in foreground state
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      final notification = remoteMessage.notification;
      // AndroidNotification? android = remoteMessage.notification?.android;

      if (notification == null) return;

      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: '@drawable/ic_launcher',
            ),
          ),
          payload: jsonEncode(remoteMessage.toMap()));

      // print('Got a message whilst in the foreground!');
      // print('Message data: ${remoteMessage.data}');
      // if (remoteMessage.notification != null) {
      //   print(
      //       'Message also contained a notification: ${remoteMessage.notification}');
      // }
    });
  }
}
