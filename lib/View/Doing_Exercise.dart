import 'package:fitnessapp/Widget/Exercise_Details.dart';
import 'package:fitnessapp/Widget/Exercise_Timer.dart';
import 'package:fitnessapp/model/Exercise.dart';
import 'package:flutter/material.dart';

class DoingExercise extends StatelessWidget {
  const DoingExercise(
      {required this.switchPrevious,
      required this.switchView,
      required this.exercise,
      super.key});
  final void Function() switchPrevious;
  final void Function() switchView;
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(exercise.name),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: true,
                        builder: (BuildContext ctx) {
                          return ExerciseDetails(exercise: exercise);
                        },
                      );
                    },
                    icon: const Icon(Icons.question_mark)),
              ],
            ),
            if (exercise.isRepetition) Text("x${exercise.repetition}"),
            if (exercise.isTimer)
              ExerciseTimer(
                minute: exercise.minute as int,
                seconds: exercise.second as int,
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      switchPrevious();
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.skip_previous_outlined),
                        Text("Previous"),
                      ],
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      switchView();
                    },
                    child: const Row(
                      children: [
                        Text("Skip"),
                        Icon(Icons.skip_next_outlined),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
