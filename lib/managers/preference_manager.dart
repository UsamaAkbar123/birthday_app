import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Keys {
  static const deviceTaken = "device_taken";
  static const birthdayReminder = "birthday_reminder";
  static const appIconIndex = "app_icon_index";
  static const zeroDayRemainder = "zero_day_remainder";
  static const oneDayRemainder = "one_day_remainder";
  static const twoDayRemainder = "two_day_remainder";
  static const threeDayRemainder = "three_day_remainder";
  static const fourDayRemainder = "four_day_remainder";
  static const fiveDayRemainder = "five_day_remainder";
  static const oneWeekDayRemainder = "one_week_day_remainder";
  static const remindMeNotificationTime = "remind_me_notification_time";
}

class PreferenceManager {
  /// Shared object which is used. No new instances are created for this class
  static final PreferenceManager _shared = PreferenceManager._internal();

  /// Factory returns `_shared` object for every
  /// instantiation like `PreferenceManager()`
  factory PreferenceManager() {
    return _shared;
  }

  /// Private constructor
  PreferenceManager._internal();

  /// SharedPreferences instance
  SharedPreferences? _prefs;

  /// Boolean get to check if `_prefs` are initialized
  bool get _isInitialized => _prefs != null;

// Set prefs
  set prefs(SharedPreferences prefs) => {
        if (_isInitialized)
          {
            debugPrint(
                "🐞 WARNING: SharedPreferences are already initialized. Should only be initialized once.")
          }
        else
          {_prefs = prefs}
      };

  /// Initializes `SharedPreferences`. This has to be set after
  /// `WidgetsFlutterBinding.ensureInitialized();`. This ensures
  /// that native libraries are loaded. Native library in this
  /// case is `SharedPreferences` instance.
  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  /// `getTaken` get & set
  String get getDeviceToken => _prefs?.getString(_Keys.deviceTaken) ?? '';
  set setDeviceToken(String value) =>
      _prefs?.setString(_Keys.deviceTaken, value);

  /// `reminder` get & set
  String get getReminder => _prefs?.getString(_Keys.birthdayReminder) ?? '';
  set setReminder(String value) =>
      _prefs?.setString(_Keys.birthdayReminder, value);

  /// `appIconIndex` get & set
  int get getAppIconIndex => _prefs?.getInt(_Keys.appIconIndex) ?? -1;
  set setAppIconIndex(int value) => _prefs?.setInt(_Keys.appIconIndex, value);

  /// 'zeroDayRemainder' get & set
  bool get getZeroDayRemainder => _prefs?.getBool(_Keys.zeroDayRemainder) ?? true;
  set setZeroDayRemainder(bool value) => _prefs?.setBool(_Keys.zeroDayRemainder, value);

  /// 'oneDayRemainder' get & set
  bool get getOneDayRemainder => _prefs?.getBool(_Keys.oneDayRemainder) ?? true;
  set setOneDayRemainder(bool value) => _prefs?.setBool(_Keys.oneDayRemainder, value);

  /// 'twoDayRemainder' get & set
  bool get getTwoDayRemainder => _prefs?.getBool(_Keys.twoDayRemainder) ?? false;
  set setTwoDayRemainder(bool value) => _prefs?.setBool(_Keys.twoDayRemainder, value);

  /// 'threeDayRemainder' get & set
  bool get getThreeDayRemainder => _prefs?.getBool(_Keys.threeDayRemainder) ?? false;
  set setThreeDayRemainder(bool value) => _prefs?.setBool(_Keys.threeDayRemainder, value);

  /// 'fourDayRemainder' get & set
  bool get getFourDayRemainder => _prefs?.getBool(_Keys.fourDayRemainder) ?? false;
  set setFourDayRemainder(bool value) => _prefs?.setBool(_Keys.fourDayRemainder, value);

  /// 'fiveDayRemainder' get & set
  bool get getFiveDayRemainder => _prefs?.getBool(_Keys.fiveDayRemainder) ?? false;
  set setFiveDayRemainder(bool value) => _prefs?.setBool(_Keys.fiveDayRemainder, value);

  /// 'oneWeekRemainder' get & set
  bool get getOneWeekRemainder => _prefs?.getBool(_Keys.oneWeekDayRemainder) ?? true;
  set setOneWeekRemainder(bool value) => _prefs?.setBool(_Keys.oneWeekDayRemainder, value);

  /// 'remindMeNotificationTime' get & set
  String get getRemindMeNotificationTime => _prefs?.getString(_Keys.remindMeNotificationTime) ?? '10:00';
  set setRemindMeNotificationTime(String value) => _prefs?.setString(_Keys.remindMeNotificationTime, value);
}
