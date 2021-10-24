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
