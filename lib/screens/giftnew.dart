import 'package:birthdates/providers/navprovider.dart';
import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:birthdates/utils/style.dart';
import 'package:birthdates/widgets/appbar.dart';
import 'package:birthdates/widgets/fadedroundbtn.dart';
import 'package:birthdates/widgets/roundbtn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GiftsNewScreen extends StatelessWidget {
  const GiftsNewScreen({super.key, this.launchedFrom});
  final int? launchedFrom;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MyAppBar(
        hasBackButton: true,
        backTo: 1,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Find the gift for',
            style: const TextStyle().medium20,
          ),
          SizedBox(
            height: context.height * 0.0175,
          ),
          RoundButton(
            title: 'Person from your Birthdates list',
            onPressed: () {
              Provider.of<NavProvider>(context, listen: false).setNavIndex(6);
            },
          ),
          FadedRoundButton(
            title: 'New person',
            onPressed: () {
              Provider.of<NavProvider>(context, listen: false).setNavIndex(7);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
            child: Text(
              'New person means, that you do not add the birthday, you just fastly answer the questions and get perfect gifts',
              style: const TextStyle().regular12LighterGrey,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: context.height * 0.1,
          ),
        ],
      ),
    );
  }
}
