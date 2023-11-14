import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:birthdates/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class BirthdayReminderCard extends StatefulWidget {
  const BirthdayReminderCard({
    required this.name,
    required this.date,
    required this.imageUrl,
    required this.onPressed,
    required this.userDateOfBirth,
    super.key,
  });

  final String name;
  final String imageUrl;
  final VoidCallback onPressed;
  final String date;

  final DateTime userDateOfBirth;

  @override
  State<BirthdayReminderCard> createState() => _BirthdayReminderCardState();
}

class _BirthdayReminderCardState extends State<BirthdayReminderCard> {
  String days = '0';
  int totalSeconds = 0;

  void _calculateDaysLeft(DateTime date) {
    final now = DateTime.now();
    final nextBirthday = DateTime(
      now.year,
      now.month,
      now.day,
    );

    if (date == nextBirthday) {
      days = 0.toString();
      setState(() {});
    } else {
      if (date.isBefore(now)) {
        date = date.add(const Duration(days: 365));
      }

      final difference = date.difference(nextBirthday);
      days = (difference.inDays).toString();
      // int res = (difference.inSeconds / 86400).truncate();
      // days = res == 0 ? res.toString() : (res - 1).toString();
      setState(() {});
    }
  }

  @override
  void initState() {
    _calculateDaysLeft(widget.userDateOfBirth);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        margin: EdgeInsets.all(5.w),
        padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 15.w),
        height: context.height * 0.09,
        width: 800.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.02),
              spreadRadius: 2,
              blurRadius: 40,
              // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(
              radius: context.height * 0.033,
              backgroundImage: widget.imageUrl == "assets/icons/usericon.png"
                  ? Image.asset('assets/images/profile.png').image
                  : NetworkImage(widget.imageUrl),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle().medium16Black,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    widget.date,
                    style: const TextStyle().regular14Grey,
                  ),
                  // SizedBox(
                  //   height: 5.h,
                  // ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            // const Spacer(),
            Container(
              // width: context.height * 0.065,
              width: 50.w,
              // height: context.height * 0.055,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.white,
                border: const GradientBoxBorder(
                  width: 1.7,
                  gradient: LinearGradient(
                    colors: AppColors.gradient,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GradientText(
                    days,
                    colors: AppColors.gradient,
                    style: const TextStyle().medium16,
                  ),
                  GradientText(
                    'days',
                    colors: AppColors.gradient,
                    style: const TextStyle().regular12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
