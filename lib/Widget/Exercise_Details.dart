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
          Text(
            exercise.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          if (exercise.isRepetition)
            Row(
              children: [
                Text(
                  "REPEATS",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Spacer(),
                Text(
                  "x${exercise.repetition}",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          if (exercise.isTimer)
            Row(
              children: [
                Text(
                  "DURATION",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Spacer(),
                Text(
                  "${exercise.minute}:${exercise.second}",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
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
  }
}
