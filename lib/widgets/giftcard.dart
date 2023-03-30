import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:birthdates/utils/style.dart';
import 'package:flutter/material.dart';

class GiftCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  const GiftCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 5),
      height: context.height * 0.105,
      width: context.width * 0.85,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: context.height * 0.0775,
            width: context.height * 0.0775,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(imageUrl),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: const TextStyle().medium14Black,
                textAlign: TextAlign.center,
              ),
              Text(
                'Presuda',
                style: const TextStyle().regular12LighterGrey,
                textAlign: TextAlign.center,
              ),
              Text(
                price,
                style: const TextStyle().medium16Black,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 100,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(colors: AppColors.gradient),
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
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: AppColors.white),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Image.asset(
                      'assets/images/amazon1.png',
                      scale: 4,
                    )
                  ],
                ),
              ),
            ],
          ),
          // Image.asset(
          //   'assets/images/buy now.png',
          //   width: 110,
          // ),
        ],
      ),
    );
  }
}
