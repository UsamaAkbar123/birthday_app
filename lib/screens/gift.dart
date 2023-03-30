import 'package:birthdates/providers/giftprovider.dart';
import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:birthdates/utils/style.dart';
import 'package:birthdates/widgets/appbar.dart';
import 'package:birthdates/widgets/showbutton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GiftScreen extends StatelessWidget {
  const GiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MyAppBar(
        hasBackButton: false,
        backTo: 9,
      ),
      body: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (context) => GiftProvider(),
          builder: (context, child) {
            var provider = Provider.of<GiftProvider>(context);
            return Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.8),
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
                  //height: context.height * 0.55,
                  width: context.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: context.height * 0.02,
                          ),
                          Container(
                            height: context.height * 0.35,
                            width: context.width * 0.75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(provider.gift.imageUrl),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: context.height * 0.02,
                          ),
                          Text(
                            provider.gift.price,
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              fontStyle: GoogleFonts.rubik().fontStyle,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: context.height * 0.02,
                          ),
                          Text(
                            provider.gift.title,
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              fontStyle: GoogleFonts.rubik().fontStyle,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: context.height * 0.0025,
                          ),
                          Text(
                            'Presuda',
                            style: const TextStyle().regular20Grey,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        width: context.width * 0.7,
                        height: 58,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.lightGrey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 10,
                              // changes position of shadow
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'BUY NOW AT',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Image.asset(
                              'assets/images/amazon.png',
                              scale: 3.5,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShowButton(
                        isYes: true,
                        onPressed: () {
                          provider.moveToNextGift();
                        },
                      ),
                      ShowButton(
                        isYes: false,
                        onPressed: () {
                          provider.moveToNextGift();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: context.height * 0.05,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
