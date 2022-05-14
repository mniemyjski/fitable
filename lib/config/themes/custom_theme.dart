import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: 'Georgia',
      brightness: Brightness.dark,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color.fromRGBO(48, 48, 48, 1.0)),
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Georgia',
      appBarTheme: AppBarTheme(color: Color.fromRGBO(0, 103, 163, 1)),
      primaryColor: Color.fromRGBO(0, 103, 163, 1),
      scaffoldBackgroundColor: Color.fromRGBO(0, 121, 191, 1),
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 24, color: Colors.white),
        // headline2: TextStyle(fontSize: 16, color: Colors.white),
        // headline3: TextStyle(color: Colors.white),
        // headline4: TextStyle(color: Colors.white),
        // headline5: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color.fromRGBO(0, 103, 163, 1)),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      cardColor: Colors.grey[200],
    );
  }
}
