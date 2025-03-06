import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

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
  late Color currentTabColor;
  @override
  void initState() {
    setState(() {
      currentTabColor = tabColor[0];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            padding: const EdgeInsets.all(15),
            backgroundColor: Colors.black,
            color: Colors.white,
            gap: 8,
            tabBackgroundColor: currentTabColor,
            onTabChange: (index) {
              setState(() {
                currentTabColor = tabColor[index];
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
            "Fitness/Diet App",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        body: Placeholder());
  }
}
