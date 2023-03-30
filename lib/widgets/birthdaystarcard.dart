import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:birthdates/utils/get_zodiac_sign.dart';
import 'package:birthdates/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BirthdayStarCard extends StatefulWidget {
  const BirthdayStarCard({
    required this.name,
    required this.star,
    required this.imageUrl,
    required this.daysLeft,
    required this.onPressed,
    required this.userDateOfBirth,
    super.key,
  });

  final String name;
  final String? imageUrl;
  final String star;
  final String daysLeft;
  final VoidCallback onPressed;
  final DateTime userDateOfBirth;

  @override
  State<BirthdayStarCard> createState() => _BirthdayStarCardState();
}

class _BirthdayStarCardState extends State<BirthdayStarCard> {
  // DateTime currentDateTime = DateTime.now();
  // DateTime currentYearDataTime = DateTime.now();
  // String days = '0';
  // int totalSeconds = 0;

  // String _calculateDaysLeft(DateTime date) {
  //   final now = DateTime.now();
  //   final nextBirthday = DateTime(now.year, date.month, date.day);
  //   currentYearDataTime = DateTime(widget.userDateOfBirth.year,
  //       widget.userDateOfBirth.month, widget.userDateOfBirth.day);
  //
  //   if (nextBirthday.isBefore(now)) {
  //     nextBirthday.add(const Duration(days: 365));
  //   }
  //
  //
  //
  //
  //
  //   if (currentYearDataTime == nextBirthday) {
  //     days = 0.toString();
  //     setState(() {});
  //   } else {
  //     currentYearDataTime = DateTime(now.year,
  //         widget.userDateOfBirth.month, widget.userDateOfBirth.day);
  //     final difference = currentYearDataTime.difference(nextBirthday);
  //     days = (difference.inDays + 1).toString();
  //     setState(() {});
  //   }
  //
  //   return days;
  //
  //   // if(difference == 0){
  //   //   return 1;
  //   // }
  // }

  // void getTimeDetails(int timeInSeconds) {
  //   int day = (((timeInSeconds / 60) / 60) / 24).floor();
  //   days = day.toString().length <= 1 ? "$day" : "$day";
  // }

  @override
  void initState() {
    // _calculateDaysLeft(currentYearDataTime);

    // Duration difference = currentYearDataTime.difference(currentDateTime);

    // if (difference.inSeconds < 0) {
    //   totalSeconds = 0;
    //   getTimeDetails(totalSeconds);
    // } else {
    //   totalSeconds = difference.inSeconds;
    //   print('Seconds: $totalSeconds');
    //   getTimeDetails(totalSeconds);
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.h, vertical: 7.w),
        padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 15.h),
        height: context.height * 0.09,
        // width: context.width * 0.85,
        width: 800.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: context.height * 0.033,
              backgroundImage: widget.imageUrl == 'assets/images/profile.png'
                  ? Image.asset('assets/images/profile.png').image
                  : Image.network(widget.imageUrl!).image,
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle().medium16Black,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    '${widget.daysLeft} days until birthday',
                    style: const TextStyle().regular14Grey,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            // const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Text(
                      ZodiacSign().getZodiacName(
                        widget.userDateOfBirth.day,
                        widget.userDateOfBirth.month,
                      ),
                      style: const TextStyle().regular14LighterGrey,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: Image.asset(
                        scale: 1.2,
                        ZodiacSign().getZodiacSign(
                          widget.userDateOfBirth.day,
                          widget.userDateOfBirth.month,
                        ),
                      ),
                    ),
                    // Image.asset(
                    //   'assets/icons/stard.png',
                    //   scale: 1.2,
                    // ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
