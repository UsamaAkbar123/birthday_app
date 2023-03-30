import 'package:birthdates/utils/colors.dart';
import 'package:birthdates/utils/context.dart';
import 'package:birthdates/utils/style.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
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
        margin: const EdgeInsets.symmetric(vertical: 20),
        //padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: isYes
              ? const LinearGradient(
                  colors: AppColors.gradient,
                )
              : null,
          color: !isYes ? AppColors.lighterGrey : null,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 50,
              // changes position of shadow
            ),
          ],
        ),
        height: context.width * 0.18,
        width: context.width * 0.18,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              isYes ? Icons.check : Icons.close,
              color: AppColors.white,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              isYes ? 'Yes' : 'No',
              style: const TextStyle().medium16,
            ),
          ],
        ),
      ),
    );
  }
}
