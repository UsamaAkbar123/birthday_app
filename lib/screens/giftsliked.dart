import 'package:birthdates/providers/giftprovider.dart';
import 'package:birthdates/providers/navprovider.dart';
import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:birthdates/utils/style.dart';
import 'package:birthdates/widgets/appbar.dart';
import 'package:birthdates/widgets/birthdaystarcard.dart';
import 'package:birthdates/widgets/giftcard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GiftsLiked extends StatelessWidget {
  const GiftsLiked({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MyAppBar(
        hasBackButton: true,
        backTo: 1,
      ),
      body: Column(
        children: [
          SizedBox(
            height: context.height * 0.01,
          ),
          Text(
            'Liked gifts',
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
                return ChangeNotifierProvider(
                  create: (context) => GiftProvider(),
                  builder: (BuildContext context, child) {
                    var provider = Provider.of<GiftProvider>(context);
                    return GiftCard(
                      title: provider.gift.title,
                      price: provider.gift.price,
                      imageUrl: provider.gift.imageUrl,
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: context.height * 0.075,
          ),
        ],
      ),
    );
  }
}
