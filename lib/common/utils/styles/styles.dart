import 'package:flat_and_fast/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppBarStyles {
  static const lightAppBarTheme = AppBarTheme(
    color: AppColors.lightAppBar,
    iconTheme: IconThemeData(color: AppColors.darkPurple),
  );

  static const darkAppBarTheme = AppBarTheme(
    color: AppColors.brightPurple,
    iconTheme: IconThemeData(color: AppColors.darkAppBar),
  );
}

abstract class ButtonStyles {
  static final ElevatedButtonThemeData elevatedButtonDarkTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 48.0),
      textStyle: TextStyles.button1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );

  static final ElevatedButtonThemeData elevatedButtonLightTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 48.0),
      textStyle: const TextStyle(
        fontFamily: FontFamily.sFProDisplay,
        fontWeight: FontWeight.w400,
        color: AppColors.darkPurple,
        fontSize: 17.0,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}

abstract class TextStyles {
  static const button1 = TextStyle(
    fontFamily: FontFamily.sFProDisplay,
    fontWeight: FontWeight.w400,
    fontSize: 17.0,
  );

  static const appBarTitle = TextStyle(
    fontFamily: FontFamily.sFProDisplay,
    fontWeight: FontWeight.w500,
    color: AppColors.dustyGray,
    fontSize: 18.0,
  );

  static const errorMessage = TextStyle(
    fontFamily: FontFamily.sFProDisplay,
    fontWeight: FontWeight.w500,
    color: AppColors.dustyGray,
    fontSize: 18.0,
  );

  static const dialogButton = TextStyle(
    fontFamily: FontFamily.sFProDisplay,
    fontWeight: FontWeight.w500,
    color: AppColors.mineShaft,
    fontSize: 14.0,
  );

  static const headline3 = TextStyle(
    fontFamily: FontFamily.sFProDisplay,
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
  );

  static const medium = TextStyle(
    fontFamily: FontFamily.sFProDisplay,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
    fontSize: 20.0,
  );

  static const headline1 = TextStyle(
    fontFamily: FontFamily.sFProDisplay,
    fontWeight: FontWeight.w600,
    color: AppColors.mineShaft,
    fontSize: 48.0,
  );
  static const headline2 = TextStyle(
    fontFamily: FontFamily.sFProDisplay,
    fontWeight: FontWeight.w600,
    color: AppColors.mineShaft,
    fontSize: 30.0,
  );
  static const headline2SecondaryColor = TextStyle(
    fontFamily: FontFamily.sFProDisplay,
    fontWeight: FontWeight.w600,
    color: AppColors.nobel,
    fontSize: 30.0,
  );
}
