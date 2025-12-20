import 'package:flutter/material.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    fontFamily: AppFonts.arabic,
    primaryColor: AppColors.greenColor,
    splashColor: AppColors.transparentColor,
    highlightColor: AppColors.transparentColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.greenColor, fontSize: AppFonts.h4),
    ),
    colorScheme: ColorScheme.fromSeed(primary: AppColors.greenColor, seedColor: AppColors.greenColor, secondary: AppColors.yellowColor),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: AppFonts.arabic,
    primaryColor: AppColors.whiteColor,
    splashColor: AppColors.transparentColor,
    highlightColor: AppColors.transparentColor,
    scaffoldBackgroundColor: AppColors.greenColor,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.whiteColor, fontSize: AppFonts.h4),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.greenColor, brightness: Brightness.dark),
  );
}
