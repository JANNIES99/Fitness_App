import 'package:fitnessapp/model/Exercise.dart';
import 'package:flutter/material.dart';

class DoingExercise extends StatelessWidget {
  const DoingExercise(
      {required this.selector, required this.exercises, super.key});
  final int selector;
  final List<Exercise> exercises;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Text(exercises[selector].name),
            if (exercises[selector].isRepetition)
              Text("x${exercises[selector].repetition}"),
          ],
        ),
      ),
    );
  }
}
