// Flutter
import 'package:flutter/material.dart';

// Project
import 'package:cinemapedia/config/colors/colors.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
          accentColor: CustomRedColor.customredAccent,
          primarySwatch: CustomRedColor.customred,
          backgroundColor: CustomBlackColor.customblack,
          cardColor: CustomBlackColor.customblackAccent,
        ),
      );
}
