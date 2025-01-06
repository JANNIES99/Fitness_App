import 'package:fitnessapp/model/Exercise.dart';
import 'package:flutter/material.dart';

class ExerciseDetails extends StatelessWidget {
  const ExerciseDetails({required this.exercise, super.key});
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Column(
        children: [
          Text(exercise.name),
          if (exercise.isRepetition)
            Row(
              children: [
                const Text("REPEATS"),
                const Spacer(),
                Text("x${exercise.repetition}"),
              ],
            ),
          if (exercise.isTimer)
            Row(
              children: [
                const Text("DURATION"),
                const Spacer(),
                Text("${exercise.minute}:${exercise.second}"),
              ],
            ),
          const Text("INSTRUCTIONS"),
          Text(exercise.instructions),
          const Text("FOCUS AREA"),
          Wrap(
            children: [
              for (final area in exercise.focusArea)
                Text("${area.name.toString().toUpperCase()} ")
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"))
        ],
      ),
    );
    ;
  }
}
