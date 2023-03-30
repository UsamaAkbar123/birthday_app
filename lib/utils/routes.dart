import 'package:birthdates/screens/home.dart';
import 'package:birthdates/screens/navscreen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const nav = 'nav';
  static const home = 'home';
  static const profile = 'profile';
  static const calender = 'calender';
  static const addNew = 'addNew';
  static const giftsList = 'giftsList';
  static const questionsList = 'questionsList';
  static const gift = 'gift';
  static const giftsLiked = 'giftsLiked';
  static const settings = 'settings';
  static const giftNew = 'giftNew';
  static const questionNew = 'questionNew';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case nav:
        return MaterialPageRoute(
          builder: (_) => const NavScreen(),
        );

      default:
        throw UnimplementedError("no route exists for ${settings.name}");
    }
  }
}
