import 'package:birthdates/firebase_services/firebase_services.dart';
import 'package:birthdates/managers/preference_manager.dart';
import 'package:birthdates/providers/navprovider.dart';
import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Item {
  final String prefix;
  final String? helper;

  const Item({required this.prefix, this.helper});
}

const items = [
  Item(prefix: '2 day before', helper: ''),
  Item(prefix: '3 day before', helper: ''),
  Item(prefix: '4 day before', helper: ''),
  Item(prefix: '5 day before', helper: ''),
];

class SelectReminderOptions extends StatefulWidget {
  const SelectReminderOptions({Key? key}) : super(key: key);

  @override
  State<SelectReminderOptions> createState() => _SelectReminderOptionsState();
}

class _SelectReminderOptionsState extends State<SelectReminderOptions> {
  final PreferenceManager _prefs = PreferenceManager();

  var _selectedIndex = -1;

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
            CupertinoFormSection.insetGrouped(
              children: [
                ...List.generate(
                  items.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() => _selectedIndex = index);
                      _prefs.setReminder = items[index].prefix.toString();
                      FirebaseServices().updateNotificationRemainderList(
                          _prefs.getDeviceToken,
                          items[index].prefix.toString());
                    },
                    child: buildCupertinoFormRow(
                      items[index].prefix,
                      items[index].helper,
                      selected: _selectedIndex == index,
                    ),
                  ),
                ),
              ],
            ),
            // Expanded(
            //   child: ListView.builder(
            //     padding: EdgeInsets.only(bottom: 80.h),
            //     shrinkWrap: true,
            //       itemBuilder: (context, index) {
            //         return GestureDetector(
            //           onTap: (){
            //             _prefs.setReminder = (index + 1).toString();
            //             navProvider.setNavIndex(3);
            //           },
            //           child: CupertinoFormSection(
            //             // header: Text('Reminder'),
            //             children: [
            //             ListTile(
            //                 title: Text('BirthDay',style:const TextStyle().medium20),
            //                 subtitle: Text('Reminder hours',style:const TextStyle().regular14Black),
            //                 trailing: Text('${index + 1} hours',style:const TextStyle().regular14Black),
            //               ),
            //             ],
            //             // backgroundColor: Colors.red,
            //           ),
            //           // child: Card(
            //           //   color: AppColors.grey.withOpacity(0.1),
            //           //   child: ListTile(
            //           //     title: Text('BirthDay',style:const TextStyle().medium20),
            //           //     subtitle: Text('Reminder hours',style:const TextStyle().regular14Black),
            //           //     trailing: Text('${index + 1} hours',style:const TextStyle().regular14Black),
            //           //   ),
            //           // ),
            //         );
            //       },
            //       itemCount: reminderList.length),
            // )
          ],
        ),
      ),
    );
  }

  Widget buildCupertinoFormRow(
    String prefix,
    String? helper, {
    bool selected = false,
  }) {
    return CupertinoFormRow(
      prefix: Text(prefix),
      helper: helper != null
          ? Text(
              helper,
              style: Theme.of(context).textTheme.bodySmall,
            )
          : null,
      child: selected
          ? const Icon(
              CupertinoIcons.check_mark,
              color: AppColors.purple,
              size: 20,
            )
          : Container(),
    );
  }
}
