import 'package:birthdates/models/birthday_model.dart';
import 'package:flutter/material.dart';

class BirthDayProvider extends ChangeNotifier {
  /// select birth day card index, and model data

  int _birthDaySelectedIndex = -1;

  get birthDaySelectedIndex => _birthDaySelectedIndex;

  BirthdayModel? birthdayModel;

  void setSelectedBirthDayCardModel({required BirthdayModel data}) {
    birthdayModel = data;
  }

  set setSelectedBirthDayCardIndex(int index) {
    _birthDaySelectedIndex = index;
  }

  List<BirthdayModel>? birthdayModeList;

  bool isDataGet = false;

  /// get birth day info from firebase services to provider
  void getBirthDayFromFirebaseService({required List<BirthdayModel> list}) {
    if (list.isEmpty) {
      birthdayModeList = [];
      isDataGet = true;
    } else {
      birthdayModeList = list;
      isDataGet = true;
    }

    notifyListeners();
    // print('Birth Day List: ${birthdayModeList?[0].imageUrl}');
  }
}
