import 'package:fitnessapp/model/Exercise.dart';
import 'package:flutter/material.dart';

class ExerciseDetails extends StatefulWidget {
  const ExerciseDetails({required this.exercise, super.key});
  final Exercise exercise;

  @override
  State<ExerciseDetails> createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
    );
  }
}
