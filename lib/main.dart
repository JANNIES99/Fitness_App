import 'package:firebase_core/firebase_core.dart';
import 'package:fitnessapp/Registration/view/profile.dart';
import 'package:fitnessapp/Registration/view/splashscreen.dart';
import 'package:fitnessapp/firebase_options.dart';
import 'package:fitnessapp/model/Theme.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions().currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  //SharedPreferences prefs = await SharedPreferences.getInstance();
  //bool hasSeenOnboarding = prefs.getBool('seenOnboarding') ?? false;

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
      home:
          // CompleteProfileView(gmail: "Hello@gmail.com")
          const Splashscreen(),
    );
  }
}
