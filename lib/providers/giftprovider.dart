import 'package:flutter/material.dart';

class GiftProvider extends ChangeNotifier {
  static GiftProvider? _instance;
  static GiftProvider getInstance() {
    if (_instance == null) {
      _instance = GiftProvider();
      return _instance!;
    } else {
      return _instance!;
    }
  }

  final _giftList = [
    Gift(
      title: 'Corner Floor Led Lamp',
      price: '\$64.50',
      imageUrl: 'assets/images/gift1.png',
    ),
    Gift(
      title: 'Cold Brew Coffee Maker',
      price: '\$31.10',
      imageUrl: 'assets/images/gift2.jpeg',
    ),
    Gift(
      title: 'Metal Chopsticks',
      price: '\$16.43',
      imageUrl: 'assets/images/gift3.jpeg',
    ),
  ];
  int _giftNum = 0;
  Gift get gift => _giftList[_giftNum];
  int get giftNum => _giftNum;
  void moveToNextGift() {
    if (_giftNum < _giftList.length - 1) {
      _giftNum++;
    } else {
      _giftNum = 0;
    }
    notifyListeners();
    //log('Notified GiftStatus');
  }
}

class Gift {
  Gift({
    required this.title,
    required this.price,
    required this.imageUrl,
  });
  String title;
  String price;
  String imageUrl;
}
