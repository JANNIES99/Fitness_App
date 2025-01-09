import 'dart:async';
import 'package:flutter/material.dart';

class BreakView extends StatefulWidget {
  const BreakView({super.key});

  @override
  State<BreakView> createState() => _BreakViewState();
}

class _BreakViewState extends State<BreakView> {
  int timeForTimer = 30;
  String timeToDisplay = "30";

  void endTheBreak() {}

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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(timeToDisplay),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        timeForTimer = timeForTimer + 10;
                        if (timeForTimer > 60) {
                          int t = timeForTimer;
                          int m = (t / 60).floor();
                          int s = t % 60;
                          timeToDisplay = "$m:$s";
                        } else {
                          timeToDisplay = timeForTimer.toString();
                        }
                      },
                    );
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
    );
  }
}
