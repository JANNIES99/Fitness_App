import 'package:fitnessapp/View/home_view.dart';
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
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        textTheme: const TextTheme().copyWith(
          headlineLarge: const TextStyle(color: Colors.black, fontSize: 14),
          headlineMedium: const TextStyle(color: Colors.black, fontSize: 12),
          headlineSmall: const TextStyle(color: Colors.blue),
          displayMedium: const TextStyle(color: Colors.black),
          displaySmall: const TextStyle(color: Colors.black),
        ),
      ),
      home: const HomeView(),
    );
  }
}
