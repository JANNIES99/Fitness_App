import 'package:fitnessapp/View/Exercise_List_View.dart';
import 'package:fitnessapp/model/Exercise.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Typesofexercises extends StatelessWidget {
  const Typesofexercises(
      {required this.exercise,
      required this.exercises,
      required this.goBackHome,
      required this.workedToday,
      required this.exerciseIndex,
      required this.buff,
      required this.daysWorked,
      super.key});
  final String exercise;
  final List<List<Exercise>> exercises;
  final int exerciseIndex;
  final double buff;
  final void Function() goBackHome;
  final void Function(double, String) workedToday;
  final Map<DateTime, List<Object>> daysWorked;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          if (exerciseIndex < exercises.length) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ExerciseListView(
                  exercise: exercise,
                  exercises: exercises[exerciseIndex],
                  goBackHome: goBackHome,
                  workedToday: workedToday,
                  buff: buff,
                  daysWorked: daysWorked,
                ),
              ),
            );
          }
        },
        child: Card(
          color: Theme.of(context).cardColor,
          child: Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 5),
                Text("$exercise EXERCISES",
                    style: Theme.of(context).textTheme.headlineSmall),
                CircularPercentIndicator(
                  radius: 27,
                  backgroundColor: Theme.of(context).colorScheme.onSecondary,
                  progressColor:
                      Theme.of(context).colorScheme.onSecondaryContainer,
                  percent: exerciseIndex / exercises.length,
                  center: Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "$exerciseIndex/${exercises.length}",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
