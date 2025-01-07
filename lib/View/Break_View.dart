import 'dart:async';
import 'dart:math';
import 'package:fitnessapp/View/Doing_Exercise.dart';
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

  void endTheBreak() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DoingExercise(
            selector: (widget.selector + 1), exercises: widget.exercises),
      ),
    );
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
            endTheBreak();
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
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(timeToDisplay),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      timeForTimer = timeForTimer + 10;
                    },
                    child: const Text("+10 Sec"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      endTheBreak();
                    },
                    child: const Text("Skip Breal"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
