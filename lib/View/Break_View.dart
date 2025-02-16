import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class BreakView extends StatefulWidget {
  const BreakView({required this.switchView, super.key});

  final void Function() switchView;
  @override
  State<BreakView> createState() => _BreakViewState();
}

class _BreakViewState extends State<BreakView> {
  int initalTime = 30;
  int timeForTimer = 30;
  String timeToDisplay = "30";

  void endTheBreak() {
    timeForTimer = 0;
    widget.switchView();
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
            CircularPercentIndicator(
              radius: 40,
              backgroundColor: Theme.of(context).colorScheme.onSecondary,
              progressColor: Theme.of(context).colorScheme.onSecondaryContainer,
              percent: timeForTimer / initalTime,
              center: Text(timeToDisplay),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        initalTime = initalTime + 10;
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
                  child: const Text("Skip Break"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
