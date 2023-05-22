import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  /// 主题颜色
  static const int _themeColorValue = 0xFF425D58;
  static const MaterialColor themeColor = MaterialColor(
    _themeColorValue,
    <int, Color>{
      50: Color(0xFF425D58),
      100: Color(0xFF425D58),
      200: Color(0xFF425D58),
      300: Color(0xFF425D58),
      400: Color(0xFF425D58),
      500: Color(0xFF425D58),
      600: Color(0xFF425D58),
      700: Color(0xFF7C9F99),
      800: Color.fromARGB(255, 95, 126, 120),
      900: Color(0xFF425D58),
    },
  );

  static const Color orangeTheme = Color(0xFFFECDA4);
  static const Color lightGreen = Color(0xFFA1BEBA);
  static const Color darkGold = Color(0xFFFECDA4);
  static const Color lightGrey = Color(0xFFA5A5A5);

  static ThemeData themeData = ThemeData(
    primarySwatch: themeColor,
    // primaryColor: themeColor,
  );
}
