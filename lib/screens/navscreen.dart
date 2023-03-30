import 'package:birthdates/providers/navprovider.dart';
import 'package:birthdates/screens/calender.dart';
import 'package:birthdates/screens/gift.dart';
import 'package:birthdates/screens/giftnew.dart';
import 'package:birthdates/screens/giftsliked.dart';
import 'package:birthdates/screens/giftslist.dart';
import 'package:birthdates/screens/home.dart';
import 'package:birthdates/screens/loading_screen_for_change_index.dart';
import 'package:birthdates/screens/profile.dart';
import 'package:birthdates/screens/profilefull.dart';
import 'package:birthdates/screens/questionslist.dart';
import 'package:birthdates/screens/select_remider_option.dart';
import 'package:birthdates/screens/settings.dart';
import 'package:birthdates/widgets/newbirthday.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:provider/provider.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int navIndex = Provider.of<NavProvider>(context,listen: false).navIndex;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SizedBox(
        height: context.height,
        width: context.width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const ScreenDecider(),
            Container(
              color: Colors.transparent,
              //height: context.height * 0.15,
              child: Container(
                height: context.height * 0.09,
                width: context.width,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lighterGrey,
                      spreadRadius: 2,
                      blurRadius: 50,
                      // changes position of shadow
                    ),
                  ],
                ),
                //padding: const EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Provider.of<NavProvider>(context, listen: false)
                            .setNavIndex(0);
                      },
                      child: Column(
                        children: [
                          Container(
                            margin:
                            const EdgeInsets.symmetric(horizontal: 8),
                            height: 4,
                            width: 45,
                            decoration: BoxDecoration(
                              gradient: navIndex == 0
                                  ? const LinearGradient(
                                colors: AppColors.gradient,
                              )
                                  : null,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            'assets/icons/calendar.png',
                            scale: 3.7,
                            color: Provider.of<NavProvider>(context)
                                .navIndex ==
                                0
                                ? null
                                : AppColors.grey,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox.shrink(),
                    InkWell(
                      onTap: () {
                        Provider.of<NavProvider>(context, listen: false)
                            .setNavIndex(2);
                      },
                      child: Column(
                        children: [
                          Container(
                            margin:
                            const EdgeInsets.symmetric(horizontal: 8),
                            height: 4,
                            width: 45,
                            decoration: BoxDecoration(
                              gradient: navIndex == 2
                                  ? const LinearGradient(
                                colors: AppColors.gradient,
                              )
                                  : null,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            'assets/icons/gift.png',
                            scale: 3.7,
                            color: Provider.of<NavProvider>(context)
                                .navIndex ==
                                2
                                ? null
                                : AppColors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: context.height * 0.055,
              // left: context.width / 2.5,
              // right: context.width / 2.5,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    elevation: 0,
                    backgroundColor: AppColors.white,
                    barrierColor: Colors.black.withOpacity(0.3),
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    builder: (context) {
                      return const NewBirthdayBottomSheet();
                    },
                  );
                },
                child: Transform.rotate(
                  angle: pi / 180 * 45,
                  child: Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: AppColors.gradient,
                      ),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenDecider extends StatelessWidget {
  const ScreenDecider({super.key});

  @override
  Widget build(BuildContext context) {
    var previousNavIndex = Provider.of<NavProvider>(context).previousNavIndex;
    int navIndex = Provider.of<NavProvider>(context).navIndex;
    switch (navIndex) {
      case 0:
        return const CalenderScreen();
      case 1:
        return const HomeScreen();
      case 2:
        return GiftsNewScreen(
          launchedFrom: previousNavIndex,
        );
      case 3:
        return SettingsScreen(
          launchedFrom: previousNavIndex,
        );
      case 4:
        return ProfileScreen(
          launchedFrom: previousNavIndex,
        );
      case 5:
        return ProfileFullScreen(
          launchedFrom: previousNavIndex,
        );
      case 6:
        return GiftsList(
          launchedFrom: previousNavIndex,
        );
      case 7:
        return QuestionsListScreen(
          launchedFrom: previousNavIndex,
        );
      case 8:
        return const GiftScreen();
      case 9:
        return const GiftsLiked();
      case 10:
        return const SelectReminderOptions();
      case 11:
        return const LoadingScreenForChangeIndex();
      default:
        return const SizedBox.shrink();
    }
  }
}
