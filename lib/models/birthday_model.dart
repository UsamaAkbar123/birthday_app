import 'package:cloud_firestore/cloud_firestore.dart';

class BirthdayModel {
  final String id;
  final String deviceToken;
  final String name;
  final String gender;
  final String imageUrl;
  final DateTime dob;
  final int actualUserDobYear;
  final List<String> notificationRemainderTime;
  final DateTime remindMe;

  BirthdayModel({
    required this.id,
    required this.deviceToken,
    required this.name,
    required this.gender,
    required this.imageUrl,
    required this.dob,
    required this.actualUserDobYear,
    required this.notificationRemainderTime,
    required this.remindMe,
  });

  factory BirthdayModel.fromMap(DocumentSnapshot<Map<String, dynamic>> data) =>
      BirthdayModel(
        id: data.data().toString().contains('id') ? data.get('id') : '',
        deviceToken: data.data().toString().contains('deviceToken')
            ? data.get('deviceToken')
            : '',
        name: data.data().toString().contains('Name') ? data.get('Name') : '',
        gender:
            data.data().toString().contains('Gender') ? data.get('Gender') : '',
        imageUrl:
            data.data().toString().contains('image') ? data.get('image') : '',
        dob: data.data().toString().contains('Date_Of_Brith')
            ? data.get('Date_Of_Brith').toDate()
            : DateTime.now(),
        actualUserDobYear:
            data.data().toString().contains('actual_user_dob_year')
                ? data.get('actual_user_dob_year')
                : 0,
        notificationRemainderTime: [],
        remindMe: DateTime.now(),
      );
}
