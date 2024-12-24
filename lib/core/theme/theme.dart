import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

ThemeData getAppDarkTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    // ScaffoldBackgroundColor
    scaffoldBackgroundColor: AppColors.background,
    // appBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      centerTitle: true,
    ),
    // Text Theme
    textTheme: TextTheme(
      displayLarge: GoogleFonts.lato(
        color: AppColors.white,
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.lato(
        color: AppColors.white,
        fontSize: 16.0,
      ),
      displaySmall: GoogleFonts.lato(
        color: AppColors.white.withOpacity(.44),
        fontSize: 16.0,
      ),
    ),
    // Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      // enabled border
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      // focused border
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      hintStyle: GoogleFonts.lato(
        color: AppColors.white,
        fontSize: 16.0,
      ),
      // fill Color
      fillColor: AppColors.lightBlack,
      filled: true,
    ),
  );
}

ThemeData getAppTheme() {
  return ThemeData(
    // primaryColor: AppColors.red,
    primaryColor: AppColors.primary,
    // ScaffoldBackgroundColor
    scaffoldBackgroundColor: AppColors.white,
    // appBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      centerTitle: true,
    ),
    // Text Theme
    textTheme: TextTheme(
      displayLarge: GoogleFonts.lato(
        color: AppColors.background,
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.lato(
        color: AppColors.background,
        fontSize: 16.0,
      ),
      displaySmall: GoogleFonts.lato(
        color: AppColors.background.withOpacity(.44),
        fontSize: 16.0,
      ),
    ),
    // Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  );
}
