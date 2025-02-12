import 'package:fitnessapp/View/Exercise_List_View.dart';
import 'package:fitnessapp/model/Exercise.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Exercisefocusareaitem extends StatelessWidget {
  const Exercisefocusareaitem(
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
            child: Container(
          margin: const EdgeInsets.all(20),
          width: double.infinity,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("$exercise EXERCISES"),
                ],
              ),
              const Spacer(),
              CircularPercentIndicator(
                radius: 25,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                progressColor:
                    Theme.of(context).colorScheme.onSecondaryContainer,
                percent: exerciseIndex / exercises.length,
                center: Text(
                  "$exerciseIndex/${exercises.length}",
                  style: TextStyle(fontSize: 14),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
