import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:birthdates/utils/style.dart';
import 'package:flutter/material.dart';

class ShowButton extends StatelessWidget {
  const ShowButton({
    super.key,
    required this.isYes,
    required this.onPressed,
  });
  final bool isYes;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: isYes
              ? const LinearGradient(
                  colors: AppColors.gradient,
                )
              : null,
          color: !isYes ? AppColors.lighterGrey : null,
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
        //height: context.width * 0.06,
        width: context.width * 0.42,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              isYes ? 'assets/icons/yes.png' : 'assets/icons/no.png',
              color: AppColors.white,
              scale: 0.9,
            ),
            // Icon(
            //   isYes ? Icons.thumb_up_outlined : Icons.thumb_down_outlined,
            //   color: AppColors.white,
            // ),
            const SizedBox(
              width: 8,
            ),
            Text(
              isYes ? 'Show similar' : 'Show other',
              style: const TextStyle().medium16,
            ),
          ],
        ),
      ),
    );
  }
}
