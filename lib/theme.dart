import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static Color mainColor = Color(0xffB799FF);
  static Color bgColor = Color(0xffE6FFFD);
  static Color appBarColor = Color(0xffAEE2FF);
  static Color titleColor = Color.fromARGB(255, 69, 161, 210);
  static Color bodyColor = Color.fromARGB(255, 105, 202, 255);
  static Color checklistColor = Color(0xffE6FFFD);
}

ThemeData primeryTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
  scaffoldBackgroundColor: AppColors.bgColor,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.appBarColor,
    foregroundColor: AppColors.titleColor,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),
  textTheme: GoogleFonts.specialEliteTextTheme(
    TextTheme(
      bodyMedium: TextStyle(
        color: AppColors.bodyColor,
        fontSize: 20,
        letterSpacing: 1,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: AppColors.bodyColor,
        fontSize: 15,
        letterSpacing: 1,
      ),
      titleMedium: TextStyle(
        color: AppColors.titleColor,
        fontSize: 15,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.titleColor,
      backgroundColor: AppColors.appBarColor,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(AppColors.appBarColor),
      foregroundColor: WidgetStateProperty.all(AppColors.titleColor),
      shape: WidgetStateProperty.all(
        CircleBorder(),
      ),
      fixedSize: WidgetStateProperty.all(
        Size(45, 45),
      ),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.all(AppColors.bodyColor),
    checkColor: WidgetStateProperty.all(Colors.white),
  ),
);
