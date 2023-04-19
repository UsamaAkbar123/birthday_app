import 'package:cloud_firestore/cloud_firestore.dart';

class BirthdayModel {
  final String id;
  final String name;
  final String gender;
  final String imageUrl;
  final DateTime dob;
  final int actualBirthDayYear;

  BirthdayModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.imageUrl,
    required this.dob,
    required this.actualBirthDayYear,
  });

  factory BirthdayModel.fromMap(DocumentSnapshot<Map<String, dynamic>> data) =>
      BirthdayModel(
        id: data.data().toString().contains('id') ? data.get('id') : '',
        name: data.data().toString().contains('Name') ? data.get('Name') : '',
        gender:
            data.data().toString().contains('Gender') ? data.get('Gender') : '',
        imageUrl:
            data.data().toString().contains('image') ? data.get('image') : '',
        dob: data.data().toString().contains('Date_Of_Brith')
            ? data.get('Date_Of_Brith').toDate()
            : DateTime.now(),
        actualBirthDayYear: data.data().toString().contains('actual_birthday_year') ? data.get('actual_birthday_year') : '',
      );
}
