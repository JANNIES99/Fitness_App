import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ExerciseTimer extends StatefulWidget {
  const ExerciseTimer({required this.minute, required this.seconds, super.key});
  final int minute;
  final int seconds;

  @override
  State<ExerciseTimer> createState() => _ExerciseTimerState();
}

class _ExerciseTimerState extends State<ExerciseTimer> {
  int timeForTimer = 0;
  int initalTime = 0;
  String timeToDisplay = "";
  @override
  void initState() {
    initalTime = ((widget.minute * 60) + widget.seconds);
    timeForTimer = ((widget.minute * 60) + widget.seconds);
    timeToDisplay = timeForTimer.toString();
    startTimer();
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
            timeToDisplay = timeForTimer.toString();
          } else {
            timeForTimer = timeForTimer - 1;
            if (timeForTimer > 60) {
              int t = timeForTimer;
              int m = (t / 60).floor();
              int s = t % 60;
              timeToDisplay = "$m:$s";
            } else {
              timeToDisplay = timeForTimer.toString();
            }
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 50,
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          progressColor: Theme.of(context).colorScheme.onSecondaryContainer,
          percent: timeForTimer / initalTime,
          center: Text(
            timeToDisplay,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
