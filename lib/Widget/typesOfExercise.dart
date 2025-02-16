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
      super.key});
  final String exercise;
  final List<List<Exercise>> exercises;
  final int exerciseIndex;
  final void Function() goBackHome;
  final void Function(double, String) workedToday;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ExerciseListView(
                exercise: exercise,
                exercises: exercises[exerciseIndex],
                goBackHome: goBackHome,
                workedToday: workedToday,
              ),
            ),
          );
        },
        child: Card(
            color: Theme.of(context).cardColor,
            child: Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 5),
                  Column(
                    children: [
                      Text("$exercise EXERCISES"),
                    ],
                  ),
                  CircularPercentIndicator(
                    radius: 30,
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
            )),
      ),
    );
  }
}
