import 'package:fitnessapp/Widget/Exercise_Details.dart';
import 'package:fitnessapp/Widget/Exercise_Item.dart';
import 'package:fitnessapp/model/Exercise.dart';
import 'package:flutter/material.dart';

class ExerciseListView extends StatelessWidget {
  const ExerciseListView({required this.exercises, super.key});
  final List<Exercise> exercises;

  @override
  Widget build(BuildContext context) {
    final int length = exercises.length;
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            ListView.builder(
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
          ],
        ));
  }
}
