import 'package:fitnessapp/model/Exercise.dart';
import 'package:flutter/material.dart';

class ExerciseItem extends StatelessWidget {
  const ExerciseItem({required this.exercise, super.key});
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Center(
              child: Text(exercise.name),
            ),
            if (exercise.isRepetition == true)
              Align(
                alignment: Alignment.centerLeft,
                child: Text("x${exercise.repetition.toString()}"),
              ),
            if (exercise.isTimer == true)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "${exercise.minute.toString()}:${exercise.second.toString()}"),
              ),
          ],
        ),
      ),
    );
  }
}
