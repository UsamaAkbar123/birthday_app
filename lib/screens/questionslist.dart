import 'package:birthdates/providers/navprovider.dart';
import 'package:birthdates/providers/questionprovider.dart';
import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:birthdates/utils/style.dart';
import 'package:birthdates/widgets/appbar.dart';
import 'package:birthdates/widgets/circlebtn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionsListScreen extends StatelessWidget {
  const QuestionsListScreen({super.key, this.launchedFrom});
  final int? launchedFrom;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MyAppBar(
        hasBackButton: true,
        backTo: launchedFrom,
      ),
      body: ChangeNotifierProvider(
        create: (context) => QuestionProvider(),
        builder: (context, child) {
          var qProvider = Provider.of<QuestionProvider>(context);
          return Column(
            children: [
              SizedBox(
                height: context.height * 0.07,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
                alignment: Alignment.center,
                height: context.height * 0.2,
                width: context.width,
                child: Text(
                  qProvider.question,
                  style: const TextStyle().medium20,
                  textAlign: TextAlign.center,
                ),
              ),
              ProgressIndicator(
                number: qProvider.questionNum,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleButton(
                    isYes: true,
                    onPressed: () {
                      if (qProvider.questionNum == 5) {
                        Provider.of<NavProvider>(context, listen: false)
                            .setNavIndex(8);
                      }
                      qProvider.moveToNextQuestion();
                    },
                  ),
                  SizedBox(
                    width: context.width * 0.125,
                  ),
                  CircleButton(
                    isYes: false,
                    onPressed: () {
                      if (qProvider.questionNum == 5) {
                        Provider.of<NavProvider>(context, listen: false)
                            .setNavIndex(8);
                      }
                      qProvider.moveToNextQuestion();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: context.height * 0.15,
              ),
              TextButton(
                onPressed: () {
                  if (qProvider.questionNum == 5) {
                    Provider.of<NavProvider>(context, listen: false)
                        .setNavIndex(8);
                  }
                  qProvider.moveToNextQuestion();
                },
                child: Text(
                  'Not sure',
                  style: const TextStyle().medium16LighterGrey,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({
    super.key,
    required this.number,
  });
  final int number;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          //padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.lighterGrey,
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
          height: 12,
          width: context.width * 0.8,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          //padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.gradient,
            ),
            color: AppColors.lighterGrey,
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
          height: 12,
          width: context.width * 0.1333 * number,
        ),
      ],
    );
  }
}
