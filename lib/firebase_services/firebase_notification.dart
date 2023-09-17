import 'dart:convert';

import 'package:birthdates/managers/preference_manager.dart';
import 'package:birthdates/models/birthday_model.dart';
import 'package:birthdates/providers/birthday_provider.dart';
import 'package:birthdates/providers/navprovider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

Future<void> handleBackgroundMessage(
  RemoteMessage message,
) async {
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

  /// initialize flutter local notification
  Future initLocalNotifications(BuildContext context) async {
    var birthdayProvider =
        Provider.of<BirthDayProvider>(context, listen: false);
    const iOS = IOSInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/blackstar');
    const setting = InitializationSettings(
      android: android,
      iOS: iOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      setting,
      onSelectNotification: (payload) {
        final Map<String, dynamic> message = jsonDecode(payload!);
        // print(message['data']['id']);

        BirthdayModel? birthdayModel = birthdayProvider.birthdayModeList!
            .firstWhere((element) => element.id == message['data']['id']);

        // handleMessage(message);
        Provider.of<NavProvider>(context, listen: false).setNavIndex(4);
        // birthdayProvider.setSelectedBirthDayCardIndex = 0;
        birthdayProvider.setSelectedBirthDayCardModel(data: birthdayModel);
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

  Future<void> initNotification(BuildContext context) async {
    var birthdayProvider =
        Provider.of<BirthDayProvider>(context, listen: false);
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
    // FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    //   await handleBackgroundMessage(message);
    // });

    /// get notification when app is in foreground state
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      final notification = remoteMessage.notification;
      // print(notification?.title);
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
              icon: '@drawable/blackstar',
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

    /// when app is open from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      //print(message);
      if (message == null) return;
      BirthdayModel? birthdayModel = birthdayProvider.birthdayModeList!
          .firstWhere((element) => element.id == message.data['id']);

      // handleMessage(message);
      Provider.of<NavProvider>(context, listen: false).setNavIndex(4);
      // birthdayProvider.setSelectedBirthDayCardIndex = 0;
      birthdayProvider.setSelectedBirthDayCardModel(data: birthdayModel);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      BirthdayModel? birthdayModel = birthdayProvider.birthdayModeList!
          .firstWhere((element) => element.id == message.data['id']);

      // handleMessage(message);
      Provider.of<NavProvider>(context, listen: false).setNavIndex(4);
      // birthdayProvider.setSelectedBirthDayCardIndex = 0;
      birthdayProvider.setSelectedBirthDayCardModel(data: birthdayModel);
    });
  }
}
