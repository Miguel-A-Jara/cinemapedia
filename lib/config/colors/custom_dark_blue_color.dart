// Flutter
import 'package:flutter/material.dart';

class CustomDarkBlueColor {
  static const MaterialColor customdarkblue =
      MaterialColor(_customdarkbluePrimaryValue, <int, Color>{
    50: Color(0xFFE0E0E7),
    100: Color(0xFFB3B3C2),
    200: Color(0xFF808099),
    300: Color(0xFF4D4D70),
    400: Color(0xFF262652),
    500: Color(_customdarkbluePrimaryValue),
    600: Color(0xFF00002E),
    700: Color(0xFF000027),
    800: Color(0xFF000020),
    900: Color(0xFF000014),
  });
  static const int _customdarkbluePrimaryValue = 0xFF000033;

  static const MaterialColor customdarkblueAccent =
      MaterialColor(_customdarkblueAccentValue, <int, Color>{
    100: Color(0xFF5555FF),
    200: Color(_customdarkblueAccentValue),
    400: Color(0xFF0000EE),
    700: Color(0xFF0000D4),
  });
  static const int _customdarkblueAccentValue = 0xFF2222FF;
}
