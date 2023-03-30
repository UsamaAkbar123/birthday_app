import 'package:birthdates/managers/preference_manager.dart';
import 'package:birthdates/providers/navprovider.dart';
import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SelectReminderOptions extends StatefulWidget {
  const SelectReminderOptions({Key? key}) : super(key: key);

  @override
  State<SelectReminderOptions> createState() => _SelectReminderOptionsState();
}

class _SelectReminderOptionsState extends State<SelectReminderOptions> {
  final PreferenceManager _prefs = PreferenceManager();
  List<int> reminderList = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
  ];

  @override
  Widget build(BuildContext context) {
    var navProvider = Provider.of<NavProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            navProvider.setNavIndex(3);
          },
          child: Image.asset(
            'assets/icons/back.png',
            scale: 2.95,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Select Reminder of birthday',
              style: const TextStyle().regular20Black,
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(bottom: 80.h),
                shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        _prefs.setReminder = (index + 1).toString();
                        navProvider.setNavIndex(3);
                      },
                      child: Card(
                        color: AppColors.grey.withOpacity(0.1),
                        child: ListTile(
                          title: Text('BirthDay',style:const TextStyle().medium20),
                          subtitle: Text('Reminder hours',style:const TextStyle().regular14Black),
                          trailing: Text('${index + 1} hours',style:const TextStyle().regular14Black),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10.h);
                  },
                  itemCount: reminderList.length),
            )
          ],
        ),
      ),
    );
  }
}
