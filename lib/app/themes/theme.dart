import 'package:flutter/material.dart';

abstract class ThemeStyles {
  static ThemeData themeStatus(bool isDarkTheme, BuildContext context) {
    return ThemeData(
        switchTheme: SwitchThemeData(
            trackColor:
                MaterialStateColor.resolveWith((states) => Colors.teal)),
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            color: Colors.teal,
            elevation: 4,
            shadowColor: Colors.white,
            titleTextStyle: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins'),
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
        ),
        primarySwatch: Colors.teal,
        useMaterial3: true,
        indicatorColor: isDarkTheme ? Colors.white70 : Colors.black54,
        brightness: isDarkTheme ? Brightness.dark : Brightness.light);
  }
}
