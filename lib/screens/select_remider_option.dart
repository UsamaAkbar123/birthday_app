import 'package:birthdates/firebase_services/firebase_services.dart';
import 'package:birthdates/managers/preference_manager.dart';
import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/style.dart';
import 'package:birthdates/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Item {
  final String prefix;
  final String? helper;

  const Item({required this.prefix, this.helper});
}

class SelectReminderOptions extends StatefulWidget {
  const SelectReminderOptions({Key? key}) : super(key: key);

  @override
  State<SelectReminderOptions> createState() => _SelectReminderOptionsState();
}

class _SelectReminderOptionsState extends State<SelectReminderOptions> {
  final PreferenceManager _prefs = PreferenceManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MyAppBar(
        hasBackButton: true,
        hasSettingIcon: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ListView(
          children: [
            SizedBox(height: 20.h),
            Text(
              'Select Your Reminder Settings',
              style: const TextStyle()
                  .regular20Black
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            RemainderBox(
              remainderText: 'on the day',
              isSelected: _prefs.getZeroDayRemainder,
              onTap: () {
                setState(() {
                  _prefs.setZeroDayRemainder = !_prefs.getZeroDayRemainder;
                });
                FirebaseServices().updateNotificationRemainderList(
                  _prefs.getDeviceToken,
                  'on the day',
                );
              },
            ),
            SizedBox(height: 12.h),
            RemainderBox(
              remainderText: '1 day before',
              isSelected: _prefs.getOneDayRemainder,
              onTap: () {
                setState(() {
                  _prefs.setOneDayRemainder = !_prefs.getOneDayRemainder;
                });
                FirebaseServices().updateNotificationRemainderList(
                  _prefs.getDeviceToken,
                  '1 day before',
                );
              },
            ),
            SizedBox(height: 12.h),
            RemainderBox(
              remainderText: '2 days before',
              isSelected: _prefs.getTwoDayRemainder,
              onTap: () {
                setState(() {
                  _prefs.setTwoDayRemainder = !_prefs.getTwoDayRemainder;
                });
                FirebaseServices().updateNotificationRemainderList(
                  _prefs.getDeviceToken,
                  '2 days before',
                );
              },
            ),
            SizedBox(height: 12.h),
            RemainderBox(
              remainderText: '3 days before',
              isSelected: _prefs.getThreeDayRemainder,
              onTap: () {
                setState(() {
                  _prefs.setThreeDayRemainder = !_prefs.getThreeDayRemainder;
                });
                FirebaseServices().updateNotificationRemainderList(
                  _prefs.getDeviceToken,
                  '3 days before',
                );
              },
            ),
            SizedBox(height: 12.h),
            RemainderBox(
              remainderText: '4 days before',
              isSelected: _prefs.getFourDayRemainder,
              onTap: () {
                setState(() {
                  _prefs.setFourDayRemainder = !_prefs.getFourDayRemainder;
                });
                FirebaseServices().updateNotificationRemainderList(
                  _prefs.getDeviceToken,
                  '4 days before',
                );
              },
            ),
            SizedBox(height: 12.h),
            RemainderBox(
              remainderText: '5 days before',
              isSelected: _prefs.getFiveDayRemainder,
              onTap: () {
                setState(() {
                  _prefs.setFiveDayRemainder = !_prefs.getFiveDayRemainder;
                });
                FirebaseServices().updateNotificationRemainderList(
                  _prefs.getDeviceToken,
                  '5 days before',
                );
              },
            ),
            SizedBox(height: 12.h),
            RemainderBox(
              remainderText: '1 week before',
              isSelected: _prefs.getOneWeekRemainder,
              onTap: () {
                setState(() {
                  _prefs.setOneWeekRemainder = !_prefs.getOneWeekRemainder;
                });
                FirebaseServices().updateNotificationRemainderList(
                  _prefs.getDeviceToken,
                  '1 week before',
                );
              },
            ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 280.h,
                        child: TimePickerWidget(
                          dateFormat: 'HH:mm',
                          onConfirm: (datetime, list) {
                            _prefs.setRemindMeNotificationTime =
                                DateFormat('h:mm a').format(datetime);
                            FirebaseServices().updateRemindMeNotificationTime(
                              _prefs.getDeviceToken,
                              datetime,
                            );
                            setState(() {});
                          },
                          onCancel: () {},
                        ),
                      );
                    });
                // TimePickerWidget
              },
              child: Container(
                height: 53.h,
                width: 327.w,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    borderRadius: BorderRadius.circular(20.r)),
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    children: [
                      GradientText(
                        'Remind me at: ',
                        style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        colors: const [AppColors.purple, AppColors.blue],
                      ),
                      GradientText(
                        _prefs.getRemindMeNotificationTime,
                        style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        colors: const [AppColors.purple, AppColors.blue],
                      ),
                      const Spacer(),
                      Icon(
                        Icons.more_horiz,
                        color: AppColors.blue,
                        size: 25.h,
                      )
                    ],
                  ),
                ),
              ),
            ),
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

class RemainderBox extends StatelessWidget {
  final String remainderText;
  final bool isSelected;
  final VoidCallback onTap;

  const RemainderBox({
    required this.remainderText,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 51.h,
        width: 327.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            colors: isSelected
                ? [
                    AppColors.purple,
                    AppColors.blue,
                  ]
                : [
                    Colors.white,
                    Colors.white,
                  ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          child: Row(
            children: [
              Text(
                remainderText,
                style: const TextStyle().medium16.copyWith(
                    color: isSelected ? Colors.white : AppColors.grey),
              ),
              const Spacer(),
              isSelected
                  ? Image.asset(
                      'assets/icons/tip.png',
                      scale: 4,
                      color: Colors.white,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
