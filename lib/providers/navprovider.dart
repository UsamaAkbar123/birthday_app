import 'package:flutter/material.dart';

class NavProvider extends ChangeNotifier {
  static NavProvider? _instance;
  static NavProvider getInstance() {
    if (_instance == null) {
      _instance = NavProvider();
      return _instance!;
    } else {
      return _instance!;
    }
  }

  int _selectedNavIndex = 1;
  int _previousNavIndex = 1;
  int get navIndex => _selectedNavIndex;
  int get previousNavIndex => _previousNavIndex;
  void setNavIndex(int index) {
    if(_selectedNavIndex != 11){
      _previousNavIndex = _selectedNavIndex;
    }
    _selectedNavIndex = index;
    notifyListeners();
    //log('Notified NavStatus');
  }
}
