import 'package:flutter/material.dart';

// class GlobalThemedata {
//   static final ColorScheme _lightColorScheme =
//       ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
//     secondaryContainer: Colors.deepPurple,
//   );
//   static final ColorScheme _darkColorScheme =
//       ColorScheme.fromSeed(seedColor: Colors.deepPurple);
//   static ThemeData _themeData(ColorScheme colorScheme, Brightness brightness) {
//     return ThemeData().copyWith(
//       colorScheme: colorScheme,
//       brightness: brightness,
//       textTheme: const TextTheme().copyWith(
//         headlineLarge: const TextStyle(color: Colors.black, fontSize: 25),
//         headlineMedium: const TextStyle(color: Colors.blue, fontSize: 20),
//         headlineSmall: const TextStyle(color: Colors.black, fontSize: 16),
//         bodyMedium: const TextStyle(color: Colors.black, fontSize: 16),
//         bodySmall: const TextStyle(color: Colors.black, fontSize: 16),
//       ),
//     );
//   }

//   static final ThemeData _lightThemeData =
//       _themeData(_lightColorScheme, Brightness.light);
//   static final ThemeData _darkThemeData =
//       _themeData(_darkColorScheme, Brightness.dark);

//   ThemeData get lightThemeData => _lightThemeData;
//   ThemeData get darkThemeData => _darkThemeData;
// }

ColorScheme lightColorScheme =
    ColorScheme.fromSeed(seedColor: Colors.deepPurple);
ThemeData lightThemeData = ThemeData().copyWith(
  colorScheme: lightColorScheme,
  brightness: Brightness.light,
  textTheme: const TextTheme().copyWith(
      headlineLarge: const TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
          color: lightColorScheme.primary,
          fontSize: 22,
          fontWeight: FontWeight.bold),
      headlineSmall: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      bodyMedium: const TextStyle(color: Colors.black, fontSize: 16),
      bodySmall: const TextStyle(color: Colors.black, fontSize: 16),
      labelSmall: const TextStyle(color: Colors.grey, fontSize: 14)),
  cardColor: lightColorScheme.secondaryContainer,
);

final ColorScheme darkColorScheme =
    ColorScheme.fromSeed(seedColor: Colors.deepPurple);
ThemeData darkThemeData = ThemeData().copyWith(
  colorScheme: darkColorScheme,
  brightness: Brightness.dark,
  textTheme: const TextTheme().copyWith(
      headlineLarge: const TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
          color: darkColorScheme.primary,
          fontSize: 22,
          fontWeight: FontWeight.bold),
      headlineSmall: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      bodyMedium: const TextStyle(color: Colors.black, fontSize: 16),
      bodySmall: const TextStyle(color: Colors.black, fontSize: 16),
      labelSmall: const TextStyle(color: Colors.grey, fontSize: 14)),
  cardColor: darkColorScheme.secondaryContainer,
);
