import 'package:flutter/material.dart';

class ExerciseTimer extends StatefulWidget {
  const ExerciseTimer({required this.minute, required this.seconds, super.key});
  final int minute;
  final int seconds;

  @override
  State<ExerciseTimer> createState() => _ExerciseTimerState();
}

class _ExerciseTimerState extends State<ExerciseTimer> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
