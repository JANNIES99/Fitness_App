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
      super.key});
  final List<Exercise> exercises;
  final String exercise;
  final void Function() goBackHome;
  final void Function(double, String) workedToday;

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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => StartingExercise(
                        exercise: exercise,
                        exercises: exercises,
                        goBackHome: goBackHome,
                        workedToday: workedToday,
                      )));
            },
            child: const Text("Start"))
      ],
    );
  }
}
