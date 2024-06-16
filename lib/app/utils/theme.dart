import 'package:flutter/material.dart';

class Themes {
  static final lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        primary: Color(0xFF097EDA),
        secondary: Color(0xFFA8A8A8),
        surface: Colors.white,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
              minimumSize:
                  WidgetStateProperty.all(const Size(double.infinity, 58)))));
}
