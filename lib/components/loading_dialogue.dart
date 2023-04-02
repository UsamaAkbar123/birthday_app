import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/style.dart';
import 'package:flutter/material.dart';



loadingDialogue(BuildContext context){
  showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: Colors.white,
      builder: (c) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          contentPadding: const  EdgeInsets.all(25),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(
                    AppColors.purple,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Text("Loading...",
                style: const TextStyle().medium14Purple,
              )
            ],
          ),
        );
      });
}

