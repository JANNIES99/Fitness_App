import 'package:flutter/material.dart';

enum AreasOfTheBody {
  abs,
  adductors,
  shoulders,
  quadriceps,
  glutes,
  calves,
  chest,
  triceps,
  back,
  hamstrings,
  biceps,
  obliques,
  core,
}

class Exercise {
  Exercise({
    required this.name,
    required this.focusArea,
    required this.instructions,
    required this.isTimer,
    required this.minute,
    required this.second,
    required this.isRepetition,
    required this.repetition,
    required this.image,
    required this.caloriesBurned,
  });
  final int? minute;
  final int? second;
  final String name;
  final List<AreasOfTheBody> focusArea;
  final String instructions;
  final bool isTimer;
  final bool isRepetition;
  final int? repetition;
  final Image image;
  final double caloriesBurned;

  Exercise.withRepetition({
    required this.name,
    required this.focusArea,
    required this.instructions,
    required this.repetition,
    required this.image,
    required this.caloriesBurned,
  })  : isRepetition = true,
        isTimer = false,
        minute = null,
        second = null;

  Exercise.withTimer({
    required this.name,
    required this.focusArea,
    required this.instructions,
    required this.minute,
    required this.second,
    required this.image,
    required this.caloriesBurned,
  })  : isRepetition = false,
        isTimer = true,
        repetition = null;
}
