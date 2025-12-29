// Application theme configuration.
//
// Defines light and dark themes, color schemes, text styles, and gradients
// used throughout the application.

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: "Poppins",
    primaryColor: Colors.amber,
    primarySwatch: Colors.amber,
    scaffoldBackgroundColor: Color(0xFFF5F6FA),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: darkYellow,
      foregroundColor: Colors.white,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[300],
      hintStyle: TextStyle(color: Colors.grey[700]),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: "Poppins",
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromARGB(255, 130, 127, 127),
      foregroundColor: Colors.white,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[800],
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[800],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
  );

  static TextStyle get headlineStyle => const TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static TextStyle get headline2Style =>
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w800);
  static TextStyle get titleStyle =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w700);

  static TextStyle get subtitleStyle =>
      const TextStyle(fontSize: 14, color: Colors.grey);

  /// Subtitle text style that adapts to theme brightness.
  static TextStyle darkSubtitleStyle(BuildContext context) => TextStyle(
    fontSize: 14,
    color:
        Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[400]
            : Colors.grey,
  );

  // Color constants
  static const Color redDarkPastel = Color(0xFFC23A22);

  static const Color yellow = Color(0xFFFFE324);
  static const Color darkYellow = Color(0xFFFFB533);
  static const LinearGradient yellowGradient = LinearGradient(
    colors: [yellow, darkYellow],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Color grayStart = Color(0xFF2E2E2E);
  static const Color grayEnd = Color(0xFF1C1C1C);

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [grayStart, grayEnd],
  );

  static const LinearGradient darkGrayGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 130, 127, 127),
      Color.fromARGB(255, 75, 75, 75),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    tileMode: TileMode.clamp,
  );
}
