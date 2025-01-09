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
    setState(() {
      selector++;
      frontView = DoingExercise(
          switchPrevious: switchToPreviousExercise,
          switchView: switchToBreakView,
          exercise: widget.exercises[selector]);
    });
  }

  void switchToPreviousExercise() {
    setState(() {
      selector--;
      frontView = DoingExercise(
          switchPrevious: switchToPreviousExercise,
          switchView: switchToBreakView,
          exercise: widget.exercises[selector]);
    });
  }

  void switchToBreakView() {
    setState(() {
      frontView = BreakView(
        switchView: switchToExerciseView,
      );
    });
  }

  @override
  void initState() {
    setState(() {
      frontView = BreakView(
        switchView: switchToExerciseView,
      );
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
