import 'package:birthdates/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

extension TextStyler on TextStyle {
  TextStyle get medium12 {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get medium16 {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get medium16LighterGrey {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.lighterGrey,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get medium16Transparent {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: Colors.transparent,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get medium16Black {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get medium16Blue {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.blue,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get regular14 {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get regular14LightBlue {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.lightBlue,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get regular14Grey {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.grey,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get medium14Black {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get medium14Purple {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.purple,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get regular14LighterGrey {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.lighterGrey,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get regular14Black {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get regular20Black {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get regular20Grey {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.grey,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get medium20 {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get medium20Grey {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.grey,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get regular12 {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get regular12LighterGrey {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.lighterGrey,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }

  TextStyle get medium32 {
    return TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 2,
      fontStyle: GoogleFonts.rubik().fontStyle,
    );
  }
}
