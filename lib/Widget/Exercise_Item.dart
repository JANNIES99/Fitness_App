import 'package:fitnessapp/model/Exercise.dart';
import 'package:flutter/material.dart';

class ExerciseItem extends StatelessWidget {
  const ExerciseItem({required this.exercise, super.key});
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Center(
              child: Text(
                exercise.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            if (exercise.isRepetition == true)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "x${exercise.repetition.toString()}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            if (exercise.isTimer == true)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${exercise.minute.toString()}:${exercise.second.toString()}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
