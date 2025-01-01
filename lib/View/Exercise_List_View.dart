import 'package:fitnessapp/Widget/Exercise_Item.dart';
import 'package:fitnessapp/model/Exercise.dart';
import 'package:flutter/material.dart';

class ExerciseListView extends StatelessWidget {
  const ExerciseListView({required this.exercises, super.key});
  final List<Exercise> exercises;

  @override
  Widget build(BuildContext context) {
    final int length = exercises.length;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: length,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () {},
              child: ExerciseItem(
                exercise: exercises[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
