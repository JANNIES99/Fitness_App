import 'dart:typed_data';
import 'package:fitnessapp/Registration/view/splashscreen.dart';
import 'package:fitnessapp/Service/Database.dart';
import 'package:fitnessapp/View/sections/diet_section.dart';
import 'package:fitnessapp/View/sections/fitness_section.dart';
import 'package:fitnessapp/View/sections/profile_section.dart';
import 'package:fitnessapp/View/sections/yoga_section.dart';
import 'package:fitnessapp/model/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({required this.user, super.key});
  final UserProfile user;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Color> tabColor = [
    Colors.deepPurple.shade200,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.blueGrey
  ];
  final List<String> appBarName = [
    "Fitness",
    "Yoga",
    "Meal Planner",
    "User Profile"
  ];
  late List<Widget> tabSections;
  late Color currentTabColor;
  late Widget currentTabSection;
  late String currentAppBarName;
  @override
  void initState() {
    setState(() {
      currentTabColor = tabColor[0];
      tabSections = [
        FitnessSection(user: widget.user),
        const YogaSection(),
        const DietSection(),
        ProfileSection(
            userData: widget.user, addImage: addImage, logOut: logOut),
      ];
      currentTabSection = tabSections[0];
      currentAppBarName = appBarName[0];
    });
    super.initState();
  }

  final DatabaseService _databaseService = DatabaseService.instance;
  void logOut() {
    _databaseService.deleteUserProfile(widget.user);
    _databaseService.deleteAllDaysWorked();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const Splashscreen();
    }));
  }

  void addImage(Uint8List image) {
    setState(() {
      widget.user.image = image;
      _databaseService.updateUserProfile(widget.user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            padding: const EdgeInsets.all(15),
            gap: 8,
            tabBackgroundColor: currentTabColor,
            onTabChange: (index) {
              setState(() {
                currentTabColor = tabColor[index];
                currentTabSection = tabSections[index];
                currentAppBarName = appBarName[index];
              });
            },
            tabs: const [
              GButton(
                icon: Icons.fitness_center,
                text: "Exercise",
              ),
              GButton(
                icon: Icons.accessibility_new_sharp,
                text: "Yoga",
              ),
              GButton(
                icon: Icons.food_bank_rounded,
                text: "Recipes",
              ),
              GButton(
                icon: Icons.person,
                text: "Profile",
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: currentTabColor,
          title: Text(
            currentAppBarName,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        body: currentTabSection);
  }
}
