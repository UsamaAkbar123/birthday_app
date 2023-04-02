import 'package:birthdates/models/birthday_model.dart';
import 'package:birthdates/providers/birthday_provider.dart';
import 'package:birthdates/providers/navprovider.dart';
import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:birthdates/widgets/birthdayremindercard.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HorizontalCardLister extends StatefulWidget {
  final List<BirthdayModel> birthDayList;
  const HorizontalCardLister({super.key, required this.birthDayList});

  @override
  State<HorizontalCardLister> createState() => _HorizontalCardListerState();
}

class _HorizontalCardListerState extends State<HorizontalCardLister> {
  int currentVal = 1;

  int selectedIndex = -1;
  int loopLengthForSlider = 0;

  @override
  void initState() {
    if (widget.birthDayList.length - 1 % 2 == 0) {
      loopLengthForSlider = widget.birthDayList.length ~/ 2;
      // print('Even case $loopLengthForSlider');
    } else {
      loopLengthForSlider = (widget.birthDayList.length / 2 + 1).toInt();
      // print('Odd case $loopLengthForSlider');
    }

    for (int i = 1; i < widget.birthDayList.length; i++) {
      // print(i);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var birthDayProvider = Provider.of<BirthDayProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: context.height * 0.23,
            width: context.width,
            child: CarouselSlider(
              items: [
                for (int i = 1;
                    i < widget.birthDayList.length;
                    widget.birthDayList.length - i != 1 ? i += 2 : i++)
                  Container(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BirthdayReminderCard(
                          name: widget.birthDayList[i].name,
                          date: DateFormat("dd MMM yyyy")
                              .format(widget.birthDayList[i].dob),
                          imageUrl: widget.birthDayList[i].imageUrl,
                          onPressed: () {
                            Provider.of<NavProvider>(context, listen: false)
                                .setNavIndex(4);
                            birthDayProvider.setSelectedBirthDayCardIndex = i;
                            birthDayProvider.setSelectedBirthDayCardModel(
                                data:  widget.birthDayList[i]);
                          },
                          userDateOfBirth: widget.birthDayList[i].dob,
                          // daysLeft: listOfDays[i],
                        ),
                        if (widget.birthDayList.length - i != 1)
                          BirthdayReminderCard(
                            name: widget.birthDayList[i + 1].name,
                            date: DateFormat("dd MMM yyyy")
                                .format(widget.birthDayList[i + 1].dob),
                            imageUrl: widget.birthDayList[i + 1].imageUrl,
                            onPressed: () {
                              Provider.of<NavProvider>(context, listen: false)
                                  .setNavIndex(4);
                              birthDayProvider.setSelectedBirthDayCardIndex = i;
                              birthDayProvider.setSelectedBirthDayCardModel(
                                  data:  widget.birthDayList[i + 1]);
                            },
                            userDateOfBirth: widget.birthDayList[i + 1].dob,
                            // daysLeft: listOfDays[i + 1],
                          ),
                      ],
                    ),
                  ),
              ],
              options: CarouselOptions(
                viewportFraction: 0.85,
                pageSnapping: true,
                onPageChanged: (index, reason) {
                  //print(index);
                  currentVal = index + 1;
                  setState(() {});
                },
                height: context.height * 0.23,
                padEnds: false,
                animateToClosest: true,
                enableInfiniteScroll: false,
              ),
            ),
          ),
          SizedBox(
            width: context.width,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 1; i < loopLengthForSlider; i++)
                      SliderLine(
                        isSelected: currentVal == i,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SliderLine extends StatelessWidget {
  const SliderLine({
    required this.isSelected,
    super.key,
  });
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7),
      height: 3,
      width: 42,
      decoration: BoxDecoration(
        gradient: isSelected
            ? const LinearGradient(
                colors: AppColors.gradient,
              )
            : null,
        color: !isSelected ? AppColors.lighterGrey : null,
      ),
    );
  }
}
