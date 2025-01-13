import 'package:fitnessapp/View/Exercise_List_View.dart';
import 'package:fitnessapp/model/allExercise.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fitness App"),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    ExerciseListView(exercises: absEasyExercise[0]),
              ),
            );
          },
          child: const Card(
            child: SizedBox(
              width: double.infinity,
              child: Text("press this"),
            ),
          ),
        ),
      ),
    );
  }
}
