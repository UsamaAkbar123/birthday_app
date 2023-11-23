import 'package:birthdates/managers/preference_manager.dart';

class HelperFunction {
  PreferenceManager preferenceManager = PreferenceManager();

  /// get the remainder list based on preference values
  List<String> getRemainderList() {
    List<String> remainderList = [];

    /// if zero day remainder is true then add the zero day remainder
    if (preferenceManager.getZeroDayRemainder) {
      remainderList.add('on the day');
    }

    ///if one day before remainder is true then add the one day before remainder
    if (preferenceManager.getOneDayRemainder) {
      remainderList.add('1 day before');
    }

    ///if two days before remainder is true then add the two days before remainder
    if (preferenceManager.getTwoDayRemainder) {
      remainderList.add('2 days before');
    }

    ///if three days before remainder is true then add the three days before remainder
    if (preferenceManager.getThreeDayRemainder) {
      remainderList.add('3 days before');
    }

    ///if four days before remainder is true then add the four days before remainder
    if (preferenceManager.getFourDayRemainder) {
      remainderList.add('4 days before');
    }

    ///if five days before remainder is true then add the five days before remainder
    if (preferenceManager.getFiveDayRemainder) {
      remainderList.add('5 days before');
    }

    ///if one week before remainder is true then add the one week before remainder
    if (preferenceManager.getOneWeekRemainder) {
      remainderList.add('1 week before');
    }

    return remainderList;
  }
}
