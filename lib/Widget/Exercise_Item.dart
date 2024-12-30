import 'package:fitnessapp/model/Exercise.dart';
import 'package:flutter/material.dart';

class ExerciseItem extends StatelessWidget {
  const ExerciseItem({required this.exercise, super.key});
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Center(
            child: Text(exercise.name),
          ),
          if (exercise.isRepetition == true)
            Text("x+${exercise.repetition.toString()}"),
          if (exercise.isTimer == true)
            Text("${exercise.minute.toString()}:${exercise.second.toString()}"),
        ],
      ),
    );
  }
}
