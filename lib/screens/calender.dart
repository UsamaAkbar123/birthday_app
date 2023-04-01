import 'package:birthdates/models/birthday_model.dart';
import 'package:birthdates/providers/birthday_provider.dart';
import 'package:birthdates/providers/navprovider.dart';
import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:birthdates/utils/style.dart';
import 'package:birthdates/widgets/appbar.dart';
import 'package:birthdates/widgets/birthdaystarcard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  DateTime dateTime = DateTime.now();
  String time = '';

  List<BirthdayModel> filterList = [];
  List<BirthdayModel> birthDayList = [];
  List<String> dateTimeList = [];
  List<String> days = [];
  DateTime userBirthDayDataTime = DateTime.now();

  void _runFiler(DateTime dateOfBirth) {
    List<BirthdayModel> results = [];
    days = [];

    for (int i = 0; i < dateTimeList.length; i++) {
      if (dateTimeList[i].toLowerCase().contains(
          DateFormat('yyyy MM dd').format(dateOfBirth).toLowerCase())) {
        results.add(birthDayList[i]);
      }
    }

    setState(
      () {
        filterList = results;
        for (int i = 0; i < filterList.length; i++) {
          _calculateDaysLeft(filterList[i].dob);
        }
      },
    );
  }

  void _calculateDaysLeft(DateTime date) {
    final now = DateTime.now();
    final nextBirthday = DateTime(now.year, now.month, now.day);
    userBirthDayDataTime = DateTime(
      date.year,
      date.month,
      date.day,
    );

    if (nextBirthday.isBefore(now)) {
      nextBirthday.add(const Duration(days: 365));
    }

    if (userBirthDayDataTime == nextBirthday) {
      days.add(0.toString());
      setState(() {});
    } else {
      userBirthDayDataTime = DateTime(
        now.year,
        date.month,
        date.day,
      );
      final difference = userBirthDayDataTime.difference(nextBirthday);
      days.add((difference.inDays).toString());
      setState(() {});
    }
  }

  @override
  void initState() {
    time = DateFormat('dd of MMMM').format(dateTime).toString();
    filterList = Provider.of<BirthDayProvider>(context, listen: false)
            .birthdayModeList ??
        [];
    birthDayList = Provider.of<BirthDayProvider>(context, listen: false)
            .birthdayModeList ??
        [];

    for (int i = 0; i < birthDayList.length; i++) {
      dateTimeList.add(
        DateFormat('yyyy MM dd').format(
          DateTime(
            DateTime.now().year,
            birthDayList[i].dob.month,
            birthDayList[i].dob.day,
          ),
        ),
      );

      _calculateDaysLeft(birthDayList[i].dob);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var birthDayProvider = Provider.of<BirthDayProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MyAppBar(
        hasBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CalenderWidget(
              listData: birthDayProvider.birthdayModeList ?? [],
              onSelectDay: (value) {
                time = DateFormat('dd of MMMM').format(value).toString();

                _runFiler(value);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              time,
              style: const TextStyle().medium20,
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filterList.length,
              itemBuilder: (context, index) {
                return BirthdayStarCard(
                  name: filterList[index].name,
                  star: 'Aries',
                  imageUrl:
                      filterList[index].imageUrl == 'assets/icons/usericon.png'
                          ? 'assets/images/profile.png'
                          : filterList[index].imageUrl,
                  daysLeft: days[index],
                  onPressed: () {
                    Provider.of<NavProvider>(context, listen: false)
                        .setNavIndex(4);
                    birthDayProvider.setSelectedBirthDayCardIndex = index;
                    birthDayProvider.setSelectedBirthDayCardModel(
                        data: filterList[index]);
                  },
                  userDateOfBirth: filterList[index].dob,
                );
              },
            ),
            SizedBox(
              height: context.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}

class CalenderWidget extends StatefulWidget {
  final List<BirthdayModel> listData;
  final ValueChanged<DateTime> onSelectDay;

  const CalenderWidget({
    super.key,
    required this.listData,
    required this.onSelectDay,
  });

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  List<DateTime> convertedDateTimeList = [];
  final DateTime _focusedDay = DateTime.now();
  List<int> intList = [];
  List<DateTime> selectedDates = [
    DateTime.now().subtract(const Duration(days: 5)),
    // DateTime.now(),
  ];

  List<int> getEvents(DateTime day) {
    if (convertedDateTimeList.isNotEmpty) {
      for (int i = 0; i < convertedDateTimeList.length; i++) {
        if (day.toString().contains(convertedDateTimeList[i].toString())) {
          intList.clear();
          intList.add(i);
          return intList;
        }
      }
    }
    return [];
  }

  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    for (int i = 0; i < widget.listData.length; i++) {
      DateTime a = DateTime(
        currentDate.year,
        widget.listData[i].dob.month,
        widget.listData[i].dob.day,
      );
      convertedDateTimeList.add(a);
      // print(convertedDateTimeList[i]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 50,
            // changes position of shadow
          ),
        ],
      ),
      width: context.width,
      child: TableCalendar(
        eventLoader: (day) {
          return getEvents(day);
        },
        daysOfWeekStyle:
            DaysOfWeekStyle(weekdayStyle: const TextStyle().regular14Grey),
        calendarStyle: CalendarStyle(
          markerMargin: const EdgeInsets.all(0),
          markersAlignment: Alignment.center,
          markerSize: 36,
          markerDecoration: BoxDecoration(
              border: Border.all(color: AppColors.purple, width: 1.5),
              shape: BoxShape.circle),
          markersAutoAligned: false,
          markersOffset: const PositionedOffset(bottom: 0, top: 0),
          outsideDaysVisible: false,
          defaultTextStyle: const TextStyle().medium16LighterGrey,
          weekendTextStyle: const TextStyle().medium16LighterGrey,
          selectedDecoration: const BoxDecoration(
              color: AppColors.purple, shape: BoxShape.circle),
          selectedTextStyle: const TextStyle().medium16,
          isTodayHighlighted: true,
          todayTextStyle: const TextStyle(
              fontSize: 16,
              color: AppColors.white,
              fontWeight: FontWeight.w600),
          todayDecoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.blue,
          ),
        ),
        headerStyle: HeaderStyle(
          headerMargin: const EdgeInsets.only(bottom: 15, top: 5),
          titleTextStyle: const TextStyle().medium20,
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronMargin: const EdgeInsets.only(left: 40),
          rightChevronMargin: const EdgeInsets.only(right: 40),
          leftChevronIcon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.lighterGrey,
            size: 20,
          ),
          rightChevronIcon: const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.lighterGrey,
            size: 20,
          ),
        ),
        rangeSelectionMode: RangeSelectionMode.enforced,
        calendarFormat: CalendarFormat.month,
        focusedDay: _focusedDay,
        firstDay: DateTime(2022, 2, 1),
        lastDay: DateTime(2023, 12, 1),
        selectedDayPredicate: (day) {
          // print(selectedDates.length);

          if (!selectedDates.contains(day)) {
            return false;
          } else {
            return true;
          }
        },
        onDaySelected: (selectedDay, focusedDay) {
          //print(selectedDay);
          widget.onSelectDay(selectedDay);
          selectedDates = [];
          selectedDates.add(selectedDay);
          setState(() {});
          // setState(() {
          //   if (selectedDates.contains(selectedDay)) {
          //     selectedDates.remove(selectedDay);
          //     setState(() {});
          //   } else {
          //     selectedDates.add(selectedDay);
          //     _focusedDay = focusedDay;
          //     setState(() {});
          //   }
          // });
        },
      ),
    );
  }
}

// class CalenderWidget extends StatefulWidget {
//   const CalenderWidget({super.key});

//   @override
//   State<CalenderWidget> createState() => _CalenderWidgetState();
// }

// class _CalenderWidgetState extends State<CalenderWidget> {
//   DateTime selectedDateTime = DateTime(2023);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.grey.withOpacity(0.05),
//             spreadRadius: 2,
//             blurRadius: 50,
//             // changes position of shadow
//           ),
//         ],
//       ),
//       height: context.height * 0.4,
//       width: context.width,
//       child: CalendarCarousel(
//         todayBorderColor: AppColors.blue,
//         //selectedDateTime: selectedDateTime,
//         selectedDayButtonColor: Colors.transparent,
//         selectedDayTextStyle: const TextStyle().medium16Blue,
//         todayButtonColor: AppColors.blue,
//         selectedDayBorderColor: AppColors.blue,
//         daysTextStyle: const TextStyle().medium16LighterGrey,
//         weekdayTextStyle: const TextStyle().regular14Grey,
//         weekendTextStyle: const TextStyle().medium16LighterGrey,
//         showOnlyCurrentMonthDate: true,
//         iconColor: AppColors.grey,
//         headerTextStyle: const TextStyle().medium20,
//         markedDateIconBorderColor: AppColors.purple,

//         onDayPressed: (p0, p1) {
//           selectedDateTime = p0;
//           setState(() {});
//         },
//       ),
//     );
//   }
// }
