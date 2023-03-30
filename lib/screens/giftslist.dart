import 'package:birthdates/providers/navprovider.dart';
import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:birthdates/utils/style.dart';
import 'package:birthdates/widgets/appbar.dart';
import 'package:birthdates/widgets/birthdaystarcard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GiftsList extends StatelessWidget {
  const GiftsList({super.key, required this.launchedFrom});
  final int? launchedFrom;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MyAppBar(
        hasBackButton: true,
        backTo: 2,
      ),
      body: Column(
        children: [
          SizedBox(
            height: context.height * 0.01,
          ),
          Text(
            'Choose a receptionist',
            style: const TextStyle().medium20,
          ),
          SizedBox(
            height: context.height * 0.0125,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              //physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: NavProvider.getInstance(),
                  child: BirthdayStarCard(
                    name: 'Max Khodzaev',
                    star: 'Aries',
                    imageUrl: 'assets/images/profile.png',
                    daysLeft: 2.toString(),
                    onPressed: () {
                      Provider.of<NavProvider>(context, listen: false)
                          .setNavIndex(7);
                    },
                    userDateOfBirth: DateTime.now(),
                  ),
                );
              },
            ),
          ),
          Container(
            height: context.height * 0.075,
          ),
        ],
      ),
    );
  }
}
