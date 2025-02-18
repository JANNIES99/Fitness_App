import 'package:fitnessapp/Registration/view/splashscreen.dart';
import 'package:fitnessapp/model/Theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: lightThemeData,
        darkTheme: darkThemeData,
        home: const Splashscreen());
  }
}
