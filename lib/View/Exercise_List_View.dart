import 'package:fitnessapp/View/Starting_Exercise.dart';
import 'package:fitnessapp/Widget/Exercise_Details.dart';
import 'package:fitnessapp/Widget/Exercise_Item.dart';
import 'package:fitnessapp/model/Exercise.dart';
import 'package:flutter/material.dart';

class ExerciseListView extends StatelessWidget {
  const ExerciseListView(
      {required this.exercises,
      required this.goBackHome,
      required this.workedToday,
      required this.exercise,
      required this.buff,
      required this.daysWorked,
      super.key});
  final List<Exercise> exercises;
  final String exercise;
  final double buff;
  final void Function() goBackHome;
  final void Function(double, String) workedToday;
  final Map<DateTime, List<Object>> daysWorked;

  @override
  Widget build(BuildContext context) {
    final int length = exercises.length;
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: length,
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (BuildContext ctx) {
                  return ExerciseDetails(exercise: exercises[index]);
                },
              );
            },
            child: ExerciseItem(
              exercise: exercises[index],
            ),
          );
        },
      ),
      persistentFooterButtons: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StartingExercise(
                    exercise: exercise,
                    exercises: exercises,
                    goBackHome: goBackHome,
                    workedToday: workedToday,
                    buff: buff,
                    daysWorked: daysWorked,
                  ),
                ),
              );
            },
            child: const Text("Start"))
      ],
    );
  }
}
