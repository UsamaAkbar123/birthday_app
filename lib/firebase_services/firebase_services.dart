import 'dart:io';

import 'package:birthdates/components/loading_dialogue.dart';
import 'package:birthdates/managers/preference_manager.dart';
import 'package:birthdates/models/birthday_model.dart';
import 'package:birthdates/providers/birthday_provider.dart';
import 'package:birthdates/providers/navprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class FirebaseServices {
  late FirebaseMessaging firebaseMessaging;
  final PreferenceManager _prefs = PreferenceManager();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  /// get device taken through firebase messaging
  Future<String> getDeviceToken() async {
    String? deviceToken;
    firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.getToken().then((value) {
      deviceToken = value;
      _prefs.setDeviceToken = value ?? '';
    });
    return deviceToken ?? '';
  }

  /// add brith day data to fireStore database
  Future<void> addUserBirthDayInfo({
    required Map<String, dynamic> data,
    required BuildContext context,
    required bool isImageNull,
  }) async {
    if (isImageNull == true) {
      loadingDialogue(context);
    }
    fireStore
        .collection('users')
        .doc(_prefs.getDeviceToken)
        .collection('brith_day_info')
        .doc(data['id'])
        .set(data)
        .then((value) async {
      await FirebaseServices()
          .getBirthDayInfo(context: context, addedData: data)
          .then((value) {
        // if (value == 'Adding Birthday Data Mode') {
          final birthdayProvider =
              Provider.of<BirthDayProvider>(context, listen: false);
          // print('Response Value: $value');
          List<BirthdayModel> birthdayListData =
              birthdayProvider.birthdayModeList ?? [];
          for (int i = 0; i < birthdayListData.length; i++) {
            if (data['id'] == birthdayListData[i].id) {
              if (i == 0) {
                Provider.of<NavProvider>(context, listen: false).setNavIndex(5);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                birthdayProvider.setSelectedBirthDayCardIndex = i;
                birthdayProvider.setSelectedBirthDayCardModel(
                  data: birthdayListData[i],
                );
                break;
              } else {
                Provider.of<NavProvider>(context, listen: false).setNavIndex(4);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                birthdayProvider.setSelectedBirthDayCardIndex = i;
                birthdayProvider.setSelectedBirthDayCardModel(
                  data: birthdayListData[i],
                );
                break;
              }
              // birthdayProvider.s
            }
          }
        // } else {
        //   Navigator.of(context).pop();
        //   Navigator.of(context).pop();
        //   Provider.of<NavProvider>(context, listen: false).setNavIndex(11);
        // }

        // if(isImageNull != true){
        //
        // }
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text('Data added successfully'),
        //     backgroundColor: Colors.greenAccent,
        //   ),
        // );
      });
      // Navigator.of(context).pop();
      // Navigator.of(context).pop();
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text('Data added successfully'),
      //   backgroundColor: Colors.greenAccent,
      // ));
      // Navigator.of(context).pop();
      // debugPrint('Data added successfully');
    }).catchError((error) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something went wrong'),
        backgroundColor: Colors.redAccent,
      ));
      debugPrint(error.toString());
    });
  }

  UploadTask? uploadTask;

  /// upload image to firebase storage
  Future<String?> uploadImage({
    required String nameOfImage,
    required String filePath,
    required BuildContext context,
    required String userName,
    required String gender,
    DateTime? dateOfBirth,
  }) async {
    loadingDialogue(context);
    Map<String, dynamic> body = {};
    final path = 'images/$nameOfImage';
    final file = File(filePath);

    final ref = FirebaseStorage.instance.ref().child(path);

    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask?.whenComplete(() {});

    final imageUrl =
        await snapshot?.ref.getDownloadURL().then((String? imageUrlLink) async {
      if (imageUrlLink != null) {
        var uuid = const Uuid();
        body = {
          "id": uuid.v4().toString(),
          "Name": userName,
          "Gender": gender,
          "Date_Of_Brith": dateOfBirth,
          "image": imageUrlLink,
        };
        await FirebaseServices().addUserBirthDayInfo(
          data: body,
          context: context,
          isImageNull: false,
        );
      } else {
        debugPrint('Image Url not found');
      }
    }).catchError((error) {
      debugPrint('Some issues in upload Image: $error');
    });

    return imageUrl;
  }

  /// get data from firebase

  Future<void> getBirthDayInfo(
      {required BuildContext context, Map<String, dynamic>? addedData}) async {
    final birthDayProvider =
        Provider.of<BirthDayProvider>(context, listen: false);

    try {
      List<BirthdayModel> birthDayList = [];
      List<DateTime> dateTimeList = [];
      List<BirthdayModel> sortedBirthDayList = [];
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireStore
          .collection('users')
          .doc(_prefs.getDeviceToken)
          .collection('brith_day_info')
          .get();

      birthDayList =
          querySnapshot.docs.map((doc) => BirthdayModel.fromMap(doc)).toList();

      birthDayList.sort(((a, b) => a.dob.compareTo(b.dob)));

      for (int i = 0; i < birthDayList.length; i++) {
        dateTimeList.add(DateTime(DateTime.now().year,
            birthDayList[i].dob.month, birthDayList[i].dob.day));

        //  print(birthDayList[i].dob);
      }

      for (int i = 0; i < dateTimeList.length; i++) {
        BirthdayModel model = BirthdayModel(
          id: birthDayList[i].id,
          name: birthDayList[i].name,
          gender: birthDayList[i].gender,
          imageUrl: birthDayList[i].imageUrl,
          dob: dateTimeList[i],
        );

        sortedBirthDayList.add(model);

        // print(sortedBirthDayList[i].dob);
      }

      sortedBirthDayList.sort(((a, b) => a.dob.compareTo(b.dob)));

      // for (int i = 0; i < sortedBirthDayList.length; i++) {
      //   print('After Sort: ${sortedBirthDayList[i].dob}');
      //   //print('Before Sort: ${birthDayList[i].dob}');
      // }

      // List<DateTime> dateTimeList = [];
      // DateFormat format = DateFormat("yyyy-MM-dd");

      // for (int i = 0; i < birthDayList.length; i++) {
      //   dateTimeList.add(format.parse(birthDayList[i].dob.toString()));
      // }

      // dateTimeList.sort((a, b) => a.compareTo(b));

      // for (int i = 0; i < birthDayList.length; i++) {
      //   print(birthDayList[
      //   i].dob);
      // }

      // birthDayList.sort()

      // for (int i = 0; i < birthDayList.length; i++) {
      //   print("dob: ${sortedBirthDayList[i].dob}   :: name: ${sortedBirthDayList[i].name}");
      // }

      birthDayProvider.getBirthDayFromFirebaseService(list: sortedBirthDayList);

      // if (birthDayList.isNotEmpty) {

      // }
    } catch (e) {
      debugPrint('Error: $e');
    }
    // if (addedData != null) {
    //   return 'Adding Birthday Data Mode';
    // } else {
    //   return 'Not Adding Birthday Data Mode';
    // }
  }

  /// delete birth day
  ///
  void deleteBirthDay({
    required String id,
    required BuildContext context,
  }) async {
    loadingDialogue(context);
    await fireStore
        .collection('users')
        .doc(_prefs.getDeviceToken)
        .collection('brith_day_info')
        .doc(id)
        .delete()
        .then((value) {
      FirebaseServices().getBirthDayInfo(context: context).then((value) {
        Navigator.of(context).pop();
        Provider.of<NavProvider>(context, listen: false).setNavIndex(1);
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //   content: Text('Data deleted successfully'),
        //   backgroundColor: Colors.greenAccent,
        // ));
      }).catchError((error) {
        Navigator.of(context).pop();
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //   content: Text('Something went Wrong'),
        //   backgroundColor: Colors.redAccent,
        // ));
        debugPrint('Error While fetching data from firebase: $error');
      });
    }).catchError((error) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something went Wrong'),
        backgroundColor: Colors.redAccent,
      ));
      debugPrint('Error While delete birth day: $error');
    });
  }
}
