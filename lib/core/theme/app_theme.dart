import 'package:flutter/material.dart';

abstract class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 4)
      )
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.teal,
      onPrimary: Colors.white,
      secondary: Colors.tealAccent,
      onSecondary: Colors.black,
      error: Colors.white,
      onError: Colors.red,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
  );
}
