import 'dart:async';

import 'package:birthdates/firebase_services/firebase_services.dart';
import 'package:birthdates/providers/birthday_provider.dart';
import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:birthdates/utils/get_zodiac_sign.dart';
import 'package:birthdates/utils/style.dart';
import 'package:birthdates/widgets/appbar.dart';
import 'package:birthdates/widgets/roundbtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.launchedFrom});

  final int? launchedFrom;

  @override
  Widget build(BuildContext context) {
    var birthDayProvider =
        Provider.of<BirthDayProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MyAppBar(
        hasBackButton: true,
        backTo: launchedFrom ?? 1,
      ),
      body: Column(
        children: [
          const ProfileCard(),
          const TimerWidget(),
          RoundButton(
            title: 'Find gifts',
            onPressed: () {},
          ),
          TextButton(
              onPressed: () {
                FirebaseServices().deleteBirthDay(
                    id: birthDayProvider.birthdayModel?.id ?? '',
                    context: context);
              },
              child: Text(
                'Delete',
                style: const TextStyle().medium16LighterGrey,
              ))
        ],
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    super.key,
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  int userAgeInYear = 0;
  String userActualDateOfBirth = '';
  String userFirstName = '';

  @override
  void initState() {
    var birthDayProvider =
        Provider.of<BirthDayProvider>(context, listen: false);
    int userYear = birthDayProvider.birthdayModel?.actualUserDobYear ?? 0;
    int currentYear = DateTime.now().year;
    List<String> nameParts =
        birthDayProvider.birthdayModel!.name.trim().split(" ");
    if (nameParts.isNotEmpty) {
      userFirstName = nameParts[0];
    } else {
      userFirstName = birthDayProvider.birthdayModel!.name;
    }

    userActualDateOfBirth = DateFormat('dd MMMM yyyy').format(
      DateTime(
        birthDayProvider.birthdayModel?.actualUserDobYear ?? 0,
        birthDayProvider.birthdayModel!.dob.month,
        birthDayProvider.birthdayModel!.dob.day,
      ),
    );

    userAgeInYear = currentYear - userYear;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var birthDayProvider = Provider.of<BirthDayProvider>(context, listen: true);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.h, vertical: 15.w),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 50,
            // changes position of shadow
          ),
        ],
      ),
      // height: context.height * 0.3,
      width: context.width,
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Text(
                ZodiacSign().getZodiacName(
                  birthDayProvider.birthdayModel!.dob.day,
                  birthDayProvider.birthdayModel!.dob.month,
                ),
                style: const TextStyle().regular14LighterGrey,
              ),
              SizedBox(
                width: 5.w,
              ),
              SizedBox(
                height: 20.h,
                width: 20.w,
                child: Image.asset(
                  scale: 1.2,
                  ZodiacSign().getZodiacSign(
                    birthDayProvider.birthdayModel!.dob.day,
                    birthDayProvider.birthdayModel!.dob.month,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 0, 20.h),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: context.height * 0.05,
                      backgroundImage:
                          birthDayProvider.birthdayModel?.imageUrl ==
                                  'assets/icons/usericon.png'
                              ? Image.asset('assets/images/profile.png').image
                              : Image.network(
                                      birthDayProvider.birthdayModel!.imageUrl)
                                  .image,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            birthDayProvider.birthdayModel?.name ??
                                'Stepa\nSpiridonov',
                            style: const TextStyle().medium20,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            '$userAgeInYear years  |  $userActualDateOfBirth',
                            style: const TextStyle().regular14LighterGrey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Tell us more about $userFirstName and here will be $userFirstName’s interests and hobbies',
                  style: const TextStyle().regular14LighterGrey,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({
    super.key,
  });

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer timer;
  DateTime currentDateTime = DateTime.now();
  late DateTime currentYearDataTime;
  String days = '00';
  String hours = '00';
  String minutes = '00';
  String seconds = '00';
  int totalSeconds = 0;

  late DateTime userDateTime;

  void getTimeDetails(int timeInSeconds) {
    int sec = timeInSeconds % 60;
    int min = (timeInSeconds / 60).floor() % 60;
    int hor = ((timeInSeconds / 60) / 60).floor() % 60;
    int day = (((timeInSeconds / 60) / 60) / 24).floor();
    setState(() {
      minutes = min.toString().length <= 1 ? "0$min" : "$min";
      seconds = sec.toString().length <= 1 ? "0$sec" : "$sec";
      hours = hor.toString().length <= 1 ? "0$hor" : "$hor";
      days = day == 0 ? "0${day + 1}" : "${day + 1}";
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (totalSeconds == 0) {
          timer.cancel();
        } else {
          getTimeDetails(totalSeconds);
          totalSeconds--;
        }
      },
    );
  }

  @override
  void initState() {
    userDateTime = Provider.of<BirthDayProvider>(context, listen: false)
        .birthdayModel!
        .dob;

    currentYearDataTime = DateTime(
      currentDateTime.year,
      userDateTime.month,
      userDateTime.day,
    );

    Duration difference = currentYearDataTime.difference(currentDateTime);

    if (difference.inSeconds < 0) {
      totalSeconds = 0;
    } else {
      totalSeconds = difference.inSeconds;
    }

    startTimer();

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.h, vertical: 15.w),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 50,
          ),
        ],
      ),
      width: context.width,
      child: Column(
        children: [
          days != '00'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        GradientText(
                          days,
                          colors: AppColors.gradient,
                          style: const TextStyle().medium32,
                        ),
                        GradientText(
                          'Days',
                          colors: AppColors.gradient,
                          style: const TextStyle().regular14,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GradientText(
                          ':',
                          colors: AppColors.gradient,
                          style: const TextStyle().medium32,
                        ),
                        GradientText(
                          ' ',
                          colors: AppColors.gradient,
                          style: const TextStyle().regular14,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GradientText(
                          hours,
                          colors: AppColors.gradient,
                          style: const TextStyle().medium32,
                        ),
                        GradientText(
                          'Hours',
                          colors: AppColors.gradient,
                          style: const TextStyle().regular14,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GradientText(
                          ':',
                          colors: AppColors.gradient,
                          style: const TextStyle().medium32,
                        ),
                        GradientText(
                          ' ',
                          colors: AppColors.gradient,
                          style: const TextStyle().regular14,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GradientText(
                          minutes,
                          colors: AppColors.gradient,
                          style: const TextStyle().medium32,
                        ),
                        GradientText(
                          'Min',
                          colors: AppColors.gradient,
                          style: const TextStyle().regular14,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GradientText(
                          ':',
                          colors: AppColors.gradient,
                          style: const TextStyle().medium32,
                        ),
                        GradientText(
                          ' ',
                          colors: AppColors.gradient,
                          style: const TextStyle().regular14,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GradientText(
                          seconds,
                          colors: AppColors.gradient,
                          style: const TextStyle().medium32,
                        ),
                        GradientText(
                          'Sec',
                          colors: AppColors.gradient,
                          style: const TextStyle().regular14,
                        ),
                      ],
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.purple,
                  ),
                ),
        ],
      ),
    );
  }
}
