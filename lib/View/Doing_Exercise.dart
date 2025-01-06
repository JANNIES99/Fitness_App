import 'package:fitnessapp/Widget/Exercise_Details.dart';
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
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(exercises[selector].name),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          builder: (BuildContext ctx) {
                            return ExerciseDetails(
                                exercise: exercises[selector]);
                          },
                        );
                      },
                      icon: const Icon(Icons.question_mark)),
                ],
              ),
              if (exercises[selector].isRepetition)
                Text("x${exercises[selector].repetition}"),
              if (exercises[selector].isTimer)
                ExerciseTimer(
                  minute: exercises[selector].minute as int,
                  seconds: exercises[selector].second as int,
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Icon(Icons.skip_previous_outlined),
                          Text("Previous"),
                        ],
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
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
      ),
    );
  }
}
