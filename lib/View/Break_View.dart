import 'dart:async';
import 'package:fitnessapp/model/Exercise.dart';
import 'package:flutter/material.dart';

class BreakView extends StatefulWidget {
  const BreakView({required this.exercises, this.selector = -1, super.key});
  final List<Exercise> exercises;
  final int selector;

  @override
  State<BreakView> createState() => _BreakViewState();
}

class _BreakViewState extends State<BreakView> {
  int timeForTimer = 30;
  String timeToDisplay = "30";

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
          timeToDisplay = timeForTimer.toString();
        });
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              Text(timeToDisplay),
            ],
          ),
        ),
      ),
    );
  }
}
