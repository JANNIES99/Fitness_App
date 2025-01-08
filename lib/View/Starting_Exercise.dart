import 'package:fitnessapp/View/Break_View.dart';
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
  @override
  void initState() {
    setState(() {
      frontView = BreakView(exercises: widget.exercises);
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
