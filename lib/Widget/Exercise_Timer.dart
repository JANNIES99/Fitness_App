import 'dart:async';
import 'package:flutter/material.dart';

class ExerciseTimer extends StatefulWidget {
  const ExerciseTimer({required this.minute, required this.seconds, super.key});
  final int minute;
  final int seconds;

  @override
  State<ExerciseTimer> createState() => _ExerciseTimerState();
}

class _ExerciseTimerState extends State<ExerciseTimer> {
  int timeForTimer = 0;
  String timeToDisplay = "";
  @override
  void initState() {
    timeForTimer = ((widget.minute * 60) + widget.seconds);
    timeToDisplay = timeForTimer.toString();
    super.initState();
  }

  void startTimer() {
    Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      (Timer t) {
        setState(() {
          if (timeForTimer < 1) {
            t.cancel();
            timeForTimer = 0;
          } else {
            timeForTimer = timeForTimer - 1;
          }
          timeToDisplay = timeForTimer.toString();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(timeToDisplay);
  }
}
