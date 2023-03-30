import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:birthdates/utils/style.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    required this.title,
    required this.onPressed,
  });
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(colors: AppColors.gradient),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 50,
              // changes position of shadow
            ),
          ],
        ),
        // height: context.height * 0.3,
        width: context.width,
        height: context.height * 0.065,
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle().medium16,
        ),
      ),
    );
  }
}
