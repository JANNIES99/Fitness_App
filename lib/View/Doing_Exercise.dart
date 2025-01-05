import 'package:fitnessapp/Widget/Exercise_Timer.dart';
import 'package:fitnessapp/model/Exercise.dart';
import 'package:flutter/material.dart';

class DoingExercise extends StatelessWidget {
  const DoingExercise(
      {/*required this.selector,*/ required this.exercises, super.key});
  final int selector = 1;
  final List<Exercise> exercises;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(exercises[selector].name),
            if (exercises[selector].isRepetition)
              Text("x${exercises[selector].repetition}"),
            if (exercises[selector].isTimer)
              ExerciseTimer(
                  minute: exercises[selector].minute as int,
                  seconds: exercises[selector].second as int)
          ],
        ),
      ),
    );
  }
}
