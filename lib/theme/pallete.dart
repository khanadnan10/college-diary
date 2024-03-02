import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Pallete {
  // Colors
  static const blackColor = Color.fromRGBO(1, 1, 1, 1); // primary color
  static const greyColor = Color.fromRGBO(26, 39, 45, 1); // secondary color
  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const whiteColor = Colors.white;
  static var blueColor = const Color(0xff3370E5);
  static var lightBlueColor = Colors.blue.shade300;

  // Themes
  static var darkModeAppTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: blackColor,
      cardColor: greyColor,
      textTheme: GoogleFonts.latoTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: drawerColor,
        iconTheme: IconThemeData(
          color: whiteColor,
        ),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: drawerColor,
      ),
      primaryColor: blueColor,
      colorScheme: ColorScheme.fromSeed(
          seedColor:
              drawerColor) // will be used as alternative background color
      );

  static var lightModeAppTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: whiteColor,
    cardColor: greyColor,
    textTheme: GoogleFonts.latoTextTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: blackColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: whiteColor,
    ),
    primaryColor: blueColor,
    colorScheme: ColorScheme.fromSeed(seedColor: whiteColor),
  );
}
