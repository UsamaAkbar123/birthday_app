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
        .collection('brith_day_info')
        .doc(data['id'])
        .set(data)
        .then((value) async {
      await FirebaseServices()
          .getBirthDayInfo(context: context, addedData: data)
          .then((value) {
        final birthdayProvider =
            Provider.of<BirthDayProvider>(context, listen: false);
        // print('Response Value: $value');
        List<BirthdayModel> birthdayListData =
            birthdayProvider.birthdayModeList ?? [];
        for (int i = 0; i < birthdayListData.length; i++) {
          if (data['id'] == birthdayListData[i].id) {
            if (i == 0) {
              Provider.of<NavProvider>(context, listen: false).setNavIndex(4);
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
          }
        }
      });
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
          "deviceToken": _prefs.getDeviceToken,
          "Name": userName,
          "Gender": gender,
          "Date_Of_Brith": dateOfBirth,
          "image": imageUrlLink,
          "actual_user_dob_year": dateOfBirth?.year,
          "notificationRemainderTime": [
            'on the day',
            '1 day before',
            '1 week before',
          ],
          "onDayNotificationStatus": false,
          "oneDayBeforeNotificationStatus": false,
          "twoDaysBeforeNotificationStatus": false,
          "threeDaysBeforeNotificationStatus": false,
          "fourDaysBeforeNotificationStatus": false,
          "fiveDaysBeforeNotificationStatus": false,
          "oneWeekBeforeNotificationStatus": false,
          "remindMe": DateTime(2023, 8, 15, 10, 00),
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

  /// update the remind me time
  Future<void> updateRemindMeNotificationTime(
    String uniqueId,
    DateTime remindMeTime,
  ) async {
    try {
      // Create a reference to the users collection in Firestore
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('brith_day_info');

      // Query for documents with the given uniqueId
      QuerySnapshot querySnapshot =
          await usersCollection.where('deviceToken', isEqualTo: uniqueId).get();

      // Iterate through the documents with the given uniqueId
      for (DocumentSnapshot document in querySnapshot.docs) {
        // Update the 'items' field in the document with the updated list
        await document.reference.update({'remindMe': remindMeTime});
      }
    } catch (e) {
      debugPrint("Error updating data: $e");
    }
  }

  /// update the notification remainder
  Future<void> updateNotificationRemainderList(
    String uniqueId,
    String notificationRemainder,
  ) async {
    try {
      // Create a reference to the users collection in Firestore
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('brith_day_info');

      // Query for documents with the given uniqueId
      QuerySnapshot querySnapshot =
          await usersCollection.where('deviceToken', isEqualTo: uniqueId).get();

      // Iterate through the documents with the given uniqueId
      for (DocumentSnapshot document in querySnapshot.docs) {
        // Fetch the current items list from Firestore
        List<dynamic> currentItems = document.get('notificationRemainderTime');
        // print(currentItems.length);

        // Check if notificationRemainder is in the list
        bool isPresent = currentItems.contains(notificationRemainder);

        if (isPresent) {
          // If it's present, remove it from the list
          currentItems.remove(notificationRemainder);
        } else {
          // If it's not present, add it to the list
          currentItems.add(notificationRemainder);
        }

        // Update the 'items' field in the document with the updated list
        await document.reference
            .update({'notificationRemainderTime': currentItems});
      }
    } catch (e) {
      debugPrint("Error updating data: $e");
    }
  }

  /// get data from firebase

  Future<void> getBirthDayInfo(
      {required BuildContext context, Map<String, dynamic>? addedData}) async {
    final birthDayProvider =
        Provider.of<BirthDayProvider>(context, listen: false);

    try {
      DateTime now = DateTime.now();

      List<BirthdayModel> listOfOldDates = [];
      List<BirthdayModel> birthDayList = [];
      List<DateTime> dateTimeList = [];
      List<BirthdayModel> sortedBirthDayList = [];
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireStore
          .collection('brith_day_info')
          .where('deviceToken', isEqualTo: _prefs.getDeviceToken)
          .get();

      // print('querysnapshot==> ${querySnapshot.size}');

      birthDayList =
          querySnapshot.docs.map((doc) => BirthdayModel.fromMap(doc)).toList();

      // print('birthDayList==> ${birthDayList[0].dob}');

      birthDayList.sort(((a, b) => a.dob.compareTo(b.dob)));

      for (int i = 0; i < birthDayList.length; i++) {
        dateTimeList.add(
          DateTime(
            DateTime.now().year,
            birthDayList[i].dob.month,
            birthDayList[i].dob.day,
          ),
        );
      }

      // print('dateTimeList==> ${dateTimeList[0]}');

      for (int i = 0; i < dateTimeList.length; i++) {
        BirthdayModel model = BirthdayModel(
          id: birthDayList[i].id,
          deviceToken: birthDayList[i].deviceToken,
          name: birthDayList[i].name,
          gender: birthDayList[i].gender,
          imageUrl: birthDayList[i].imageUrl,
          dob: dateTimeList[i],
          actualUserDobYear: birthDayList[i].actualUserDobYear,
          notificationRemainderTime: [],
          remindMe: DateTime.now(),
        );

        sortedBirthDayList.add(model);
      }
      // print('sortedBirthDayList==> ${sortedBirthDayList[0].dob}');

      sortedBirthDayList.sort(((a, b) => a.dob.compareTo(b.dob)));

      for (int i = 0; i < sortedBirthDayList.length; i++) {
        if (sortedBirthDayList[i].dob.month <= now.month &&
            sortedBirthDayList[i].dob.day < now.day) {
          // print('object');
          listOfOldDates.add(sortedBirthDayList[i]);
        }
      }

      // print('listOfOldDates==> ${listOfOldDates.length}');

      if (listOfOldDates.isNotEmpty) {
        listOfOldDates.sort(((a, b) => a.dob.compareTo(b.dob)));

        sortedBirthDayList
            .removeWhere((element) => listOfOldDates.contains(element));

        sortedBirthDayList.addAll(listOfOldDates);
      }
      // print('sortedBirthDayList==> ${sortedBirthDayList[0].dob}');
      birthDayProvider.getBirthDayFromFirebaseService(list: sortedBirthDayList);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  /// delete birth day
  ///
  void deleteBirthDay({
    required String id,
    required BuildContext context,
  }) async {
    loadingDialogue(context);
    await fireStore.collection('brith_day_info').doc(id).delete().then((value) {
      FirebaseServices().getBirthDayInfo(context: context).then((value) {
        Navigator.of(context).pop();
        Provider.of<NavProvider>(context, listen: false).setNavIndex(1);
      }).catchError((error) {
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
