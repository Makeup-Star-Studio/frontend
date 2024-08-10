import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';

class AppTheme {
  AppTheme._();

  // light theme
  static getApplicationTheme(BuildContext context) {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: AppColorConstant.secondaryColor,
      ),

      fontFamily: "Questrial",
      useMaterial3: true,

      // scaffoldBackgroundColor: AppColorConstant.mainSecondaryColor,

      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColorConstant.iconBgColor,
        iconTheme: IconThemeData(color: AppColorConstant.black),
      ),

      // bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: AppColorConstant.primaryAccentColor,
      //   selectedItemColor: const Color.fromARGB(255, 250, 196, 196),
      //   unselectedItemColor: AppColorConstant.whiteTextColor,
      //   showSelectedLabels: false, // Hide the labels
      //   showUnselectedLabels: false, // Hide the labels
      // ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorConstant.buttonColor,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        ),
      ),

      // iconButtonTheme: IconButtonThemeData(
      //     style: IconButton.styleFrom(
      //         foregroundColor: AppColorConstant.black)),
    );
  }
}
