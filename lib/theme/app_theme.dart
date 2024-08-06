import 'package:flutter/material.dart';
import 'package:setu_todo/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    textTheme: TextTheme(
      titleMedium: GoogleFonts.manrope(
        color: AppColors.appPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w800,
        height: 1.3,
      ),
      bodyMedium: GoogleFonts.manrope(
        color: AppColors.appText,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.3,
      ),
    ),
  );
}
