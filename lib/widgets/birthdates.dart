import 'package:birthdates/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class BirthDates extends StatelessWidget {
  const BirthDates({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientText(
      'Birthdates',
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      colors: const [AppColors.purple, AppColors.blue],
    );
  }
}
