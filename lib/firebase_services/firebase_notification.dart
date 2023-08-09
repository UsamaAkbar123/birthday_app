import 'package:birthdates/managers/preference_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print(message.notification?.title);
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
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
