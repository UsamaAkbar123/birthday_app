import 'package:birthdates/firebase_services/firebase_services.dart';
import 'package:birthdates/models/birthday_model.dart';
import 'package:birthdates/providers/birthday_provider.dart';
import 'package:birthdates/providers/navprovider.dart';
import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:birthdates/utils/style.dart';
import 'package:birthdates/widgets/appbar.dart';
import 'package:birthdates/widgets/horizontalcardlister.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BirthdayModel> sortedList = [];

  @override
  void initState() {
    FirebaseServices().getBirthDayInfo(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var birthdayProvider = Provider.of<BirthDayProvider>(context, listen: true);
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: const MyAppBar(),
        body: SingleChildScrollView(
          child: birthdayProvider.isDataGet
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      height: context.width * 0.277,
                      child: ListView(
                        padding: const EdgeInsets.only(left: 25),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          Image.asset(
                            'assets/icons/Stories.png',
                            width: context.width * 0.3,
                          ),
                          Image.asset(
                            'assets/icons/Stories2.png',
                            width: context.width * 0.3,
                          ),
                          Image.asset(
                            'assets/icons/Stories3.png',
                            width: context.width * 0.3,
                          ),
                          Image.asset(
                            'assets/icons/Stories.png',
                            width: context.width * 0.3,
                          ),
                        ],
                      ),
                    ),
                    birthdayProvider.birthdayModeList?.length != 0
                        ? MainHomeCard(
                            birthdayModel:
                                birthdayProvider.birthdayModeList![0],
                            onTab: () {
                              Provider.of<NavProvider>(context, listen: false)
                                  .setNavIndex(4);
                              birthdayProvider.setSelectedBirthDayCardIndex = 0;
                              birthdayProvider.setSelectedBirthDayCardModel(
                                  data: birthdayProvider.birthdayModeList![0]);
                            },
                          )
                        : const Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Text('No upcoming birthdays soon')),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Upcoming',
                      style: const TextStyle().medium20,
                    ),
                    birthdayProvider.birthdayModeList?.length != 0
                        ? HorizontalCardLister(
                            birthDayList:
                                birthdayProvider.birthdayModeList ?? [])
                        : const Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Text(
                                'Add a new birthday below to get started')),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}

class FeatureWidget extends StatelessWidget {
  const FeatureWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.width * 0.25,
      width: context.width * 0.25,
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
        border: const GradientBoxBorder(
          width: 2,
          gradient: LinearGradient(
            colors: AppColors.gradient,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: AppColors.gradient,
          ),
        ),
        padding: const EdgeInsets.all(10),
        alignment: Alignment.bottomLeft,
        child: SizedBox(
          width: (context.width * 0.2) / 2,
          child: Text(
            title,
            style: const TextStyle().medium12,
          ),
        ),
      ),
    );
  }
}

class MainHomeCard extends StatefulWidget {
  final BirthdayModel birthdayModel;
  final VoidCallback onTab;

  const MainHomeCard({
    required this.birthdayModel,
    required this.onTab,
    super.key,
  });

  @override
  State<MainHomeCard> createState() => _MainHomeCardState();
}

class _MainHomeCardState extends State<MainHomeCard> {
  DateTime currentDateTime = DateTime.now();
  late DateTime currentYearDataTime;
  String days = '0';
  int totalSeconds = 0;

  void _calculateDaysLeft(DateTime date) {
    final now = DateTime.now();
    final nextBirthday = DateTime(
      now.year,
      now.month,
      now.day,
    );

    // if (nextBirthday.isBefore(now)) {
    //   nextBirthday.add(const Duration(days: 365));
    // }

    //final difference = nextBirthday.difference(now);

    if (date == nextBirthday) {
      days = 0.toString();
      setState(() {});
    } else {
      currentYearDataTime = DateTime(
        now.year,
        widget.birthdayModel.dob.month,
        widget.birthdayModel.dob.day,
      );
      final difference = currentYearDataTime.difference(nextBirthday);
      days = (difference.inDays).toString();
      setState(() {});
    }

  }


  @override
  void initState() {
    currentYearDataTime = DateTime(
      widget.birthdayModel.dob.year,
      widget.birthdayModel.dob.month,
      widget.birthdayModel.dob.day,
    );

    Duration difference = currentYearDataTime.difference(currentDateTime);

    if (difference.inSeconds < 0) {
      totalSeconds = 0;
    } else {
      totalSeconds = difference.inSeconds;

    }
    _calculateDaysLeft(currentYearDataTime);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTab,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        height: context.height * 0.15,
        width: context.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: const LinearGradient(
            colors: AppColors.gradient,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 50,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              days,
              style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  fontSize: days.length == 3 ? 50.sp : 70.sp,
                  fontWeight: FontWeight.w600,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3
                    ..color = AppColors.white,
                ),
              ),
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
                    'Days to go until',
                    style: const TextStyle().regular14,
                  ),
                  Text(
                    widget.birthdayModel.name,
                    style: const TextStyle().medium16,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            CircleAvatar(
              radius: context.height * 0.05.r,
              // radius: 0.5.r,
              backgroundColor: AppColors.white,
              child: CircleAvatar(
                radius: context.height * 0.048.r,
                backgroundImage:
                    widget.birthdayModel.imageUrl == 'assets/icons/usericon.png'
                        ? Image.asset('assets/images/profile.png').image
                        : NetworkImage(widget.birthdayModel.imageUrl),
              ),
            )
          ],
        ),
      ),
    );
  }
}
