import 'package:fitnessapp/Registration/view/login_view.dart';
import 'package:fitnessapp/Service/Database.dart';
import 'package:fitnessapp/View/home_view.dart';
import 'package:fitnessapp/model/userProfile.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  UserProfile? user;
  final DatabaseService _databaseService = DatabaseService.instance;
  void getProfileData() async {
    UserProfile? userData = await _databaseService.getUserProfile();
    setState(() {
      user = userData;
    });
  }

  void updateUserProfile(UserProfile userInfo) {
    user = userInfo;
    _databaseService.updateUserProfile(userInfo);
  }

  @override
  void initState() {
    getProfileData();

    Future.delayed(const Duration(seconds: 3), () {
      if (user == null) {
        openLogin();
      } else {
        openDashboard();
      }
    });

    super.initState();
  }

  void openDashboard() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomeView(user: user!);
    }));
  }

  void openLogin() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LoginView();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
