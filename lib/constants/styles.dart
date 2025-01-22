import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();
  static final AppThemes _instance = AppThemes._();
  static AppThemes get instance => _instance;

  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFFF66435),
    primaryColorDark: const Color(0xFF130601),
    primaryColorLight: const Color(0xFFFEF1EC),
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: Colors.grey.shade50,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        titleTextStyle: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black)),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 16.0),
      titleMedium: TextStyle(fontSize: 14.0),
      titleSmall: TextStyle(fontSize: 12.0),
      labelSmall: TextStyle(fontSize: 14.0),
      labelMedium: TextStyle(fontSize: 16.0),
      labelLarge: TextStyle(fontSize: 18.0),
      headlineLarge: TextStyle(fontSize: 22.0),
      headlineMedium: TextStyle(fontSize: 18.0),
      headlineSmall: TextStyle(fontSize: 16.0),
      displaySmall: TextStyle(fontSize: 20.0),
      displayMedium: TextStyle(fontSize: 24.0),
      displayLarge: TextStyle(fontSize: 30.0),
      bodyLarge: TextStyle(fontSize: 16.0),
      bodyMedium: TextStyle(fontSize: 14.0),
      bodySmall: TextStyle(fontSize: 12.0),
    ),
  );

  static Color defaultTheme = Colors.grey.shade200;
  static Color borderTheme = Colors.grey.shade200;
}

class AppDimensions {
  static const double buttonHeight = 56.0;
  static const double borderRadius = 16.0;
  static const double borderWidth = 1.0;
}

class AppStyles {
  static BoxShadow boxShadow({
    double blurRadius = 6.0,
    Color color = const Color(0x08000000),
    double spreadRadius = 0.0,
    Offset offset = Offset.zero,
  }) {
    return BoxShadow(
      blurRadius: blurRadius,
      color: color,
      spreadRadius: spreadRadius,
      offset: offset,
    );
  }
}
