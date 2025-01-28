import 'package:fitnessapp/View/Exercise_List_View.dart';
import 'package:fitnessapp/model/allExercisePlain.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  final int streaks = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fitness App"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Card(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Weekly goals",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Text(
                    "$streaks days",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ExerciseListView(exercises: absEasyExercise[0]),
                  ),
                );
              },
              child: Card(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: 50,
                  child: Image.asset("images/abs.jpg"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
