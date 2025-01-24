import 'package:flutter/material.dart';

class GlobalThemedata {
  static final ColorScheme _lightColorScheme =
      ColorScheme.fromSeed(seedColor: Colors.orange);
  static final ColorScheme _darkColorScheme =
      ColorScheme.fromSeed(seedColor: Colors.deepOrange);
  static ThemeData _themeData(ColorScheme colorScheme, Brightness brightness) {
    return ThemeData().copyWith(
      colorScheme: colorScheme,
      brightness: brightness,
      textTheme: const TextTheme().copyWith(
        headlineLarge: const TextStyle(color: Colors.black, fontSize: 16),
        headlineMedium: const TextStyle(color: Colors.blue, fontSize: 14),
        headlineSmall: const TextStyle(color: Colors.black, fontSize: 14),
        bodyMedium: const TextStyle(color: Colors.black, fontSize: 12),
        bodySmall: const TextStyle(color: Colors.black, fontSize: 12),
      ),
    );
  }

  static final ThemeData _lightThemeData =
      _themeData(_lightColorScheme, Brightness.light);
  static final ThemeData _darkThemeData =
      _themeData(_darkColorScheme, Brightness.dark);

  ThemeData get lightThemeData => _lightThemeData;
  ThemeData get darkThemeData => _darkThemeData;
}
