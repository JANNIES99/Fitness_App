import 'package:fitnessapp/Service/Database.dart';
import 'package:fitnessapp/View/home_view.dart';
import 'package:fitnessapp/model/Theme.dart';
import 'package:fitnessapp/model/userProfile.dart';
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
  UserProfile? user;
  final DatabaseService _databaseService = DatabaseService.instance;
  void getProfileData() async {
    UserProfile? userData = await _databaseService.getUserProfile();
    print(userData!.streak);
    setState(() {
      user = userData;
    });
  }

  @override
  void initState() {
    setState(() {
      getProfileData();
    });
    print(user);
    super.initState();
  }

  void setData() {
    _databaseService.addToProfile(defaultUser);
    setState(() {
      getProfileData();
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightThemeData,
      darkTheme: darkThemeData,
      home: user != null
          ? HomeView(user: user!)
          : Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    setData();
                  },
                  child: const Text("Enter Data"),
                ),
              ),
            ),
    );
  }
}
