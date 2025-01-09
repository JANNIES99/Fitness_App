import 'package:fitnessapp/View/Break_View.dart';
import 'package:fitnessapp/View/Doing_Exercise.dart';
import 'package:fitnessapp/model/Exercise.dart';
import 'package:flutter/material.dart';

class StartingExercise extends StatefulWidget {
  const StartingExercise({required this.exercises, super.key});
  final List<Exercise> exercises;

  @override
  State<StartingExercise> createState() => _StartingExerciseState();
}

class _StartingExerciseState extends State<StartingExercise> {
  Widget? frontView;
  int selector = -1;

  void switchToExerciseView() {
    selector++;
    frontView = DoingExercise(selector: selector, exercises: widget.exercises);
  }

  void switchToBreakView() {
    frontView = const BreakView();
  }

  @override
  void initState() {
    setState(() {
      frontView = const BreakView();
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: frontView,
    );
  }
}
