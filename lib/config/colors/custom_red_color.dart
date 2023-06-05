import 'package:flutter/material.dart';

class CustomRedColor {
  static const MaterialColor customred =
      MaterialColor(_customredPrimaryValue, <int, Color>{
    50: Color(0xFFF9E0E0),
    100: Color(0xFFF0B3B3),
    200: Color(0xFFE68080),
    300: Color(0xFFDB4D4D),
    400: Color(0xFFD42626),
    500: Color(_customredPrimaryValue),
    600: Color(0xFFC70000),
    700: Color(0xFFC00000),
    800: Color(0xFFB90000),
    900: Color(0xFFAD0000),
  });
  static const int _customredPrimaryValue = 0xFFCC0000;

  static const MaterialColor customredAccent =
      MaterialColor(_customredAccentValue, <int, Color>{
    100: Color(0xFFFFD7D7),
    200: Color(_customredAccentValue),
    400: Color(0xFFFF7171),
    700: Color(0xFFFF5858),
  });
  static const int _customredAccentValue = 0xFFFFA4A4;
}
