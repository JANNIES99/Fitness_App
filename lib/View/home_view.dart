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
      body: Container(
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
    );
  }
}
