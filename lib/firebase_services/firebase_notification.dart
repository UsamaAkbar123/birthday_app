import 'package:birthdates/managers/preference_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  // print(message.notification?.title);
}

class FirebaseNotification {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final preference = PreferenceManager();

  Future<void> initNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await _firebaseMessaging.requestPermission();
    // final fcmToken = preference.getDeviceToken;
    // print(fcmToken);

    /// get notification when app is in background state
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    /// get notification when app is in foreground state
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      // print('Got a message whilst in the foreground!');
      // print('Message data: ${remoteMessage.data}');
      // if (remoteMessage.notification != null) {
      //   print(
      //       'Message also contained a notification: ${remoteMessage.notification}');
      // }
    });
  }
}
