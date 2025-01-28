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
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          if (exercise.isRepetition)
            Row(
              children: [
                Text(
                  "REPEATS",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Spacer(),
                Text(
                  "x${exercise.repetition}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          if (exercise.isTimer)
            Row(
              children: [
                Text(
                  "DURATION",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Spacer(),
                Text(
                  "${exercise.minute}:${exercise.second}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          const SizedBox(
            height: 10,
          ),
          Text("INSTRUCTIONS",
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(
            height: 10,
          ),
          Text(exercise.instructions,
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(
            height: 10,
          ),
          Text("FOCUS AREA", style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            children: [
              for (final area in exercise.focusArea)
                Container(
                  margin: const EdgeInsets.all(5),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Text("${area.name.toString().toUpperCase()} "),
                )
            ],
          ),
          const SizedBox(
            height: 10,
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
