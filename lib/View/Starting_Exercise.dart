import 'package:fitnessapp/View/Break_View.dart';
import 'package:fitnessapp/View/Doing_Exercise.dart';
import 'package:fitnessapp/model/Exercise.dart';
import 'package:fitnessapp/model/Theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StartingExercise extends StatefulWidget {
  const StartingExercise({required this.exercises, super.key});
  final List<Exercise> exercises;

  @override
  State<StartingExercise> createState() => _StartingExerciseState();
}

class _StartingExerciseState extends State<StartingExercise> {
  Widget? frontView;
  int selector = -1;

  void goBack() {
    Navigator.of(context).pop();
  }

  void switchToExerciseView() {
    setState(() {
      selector++;
      frontView = DoingExercise(
          switchPrevious: switchToPreviousExercise,
          switchView: switchToBreakView,
          goBack: goBack,
          exercise: widget.exercises[selector]);
    });
  }

  void switchToPreviousExercise() {
    if (selector > 0) {
      setState(() {
        selector--;
        frontView = DoingExercise(
            switchPrevious: switchToPreviousExercise,
            switchView: switchToBreakView,
            goBack: goBack,
            exercise: widget.exercises[selector]);
      });
    }
  }

  void switchToBreakView() {
    if (selector + 1 < widget.exercises.length) {
      setState(() {
        frontView = BreakView(
          switchView: switchToExerciseView,
        );
      });
    } else {
      animatedChecker();
    }
  }

  @override
  void initState() {
    setState(() {
      frontView = BreakView(
        switchView: switchToExerciseView,
      );
      super.initState();
    });
  }

  @override
  void animatedChecker() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LottieBuilder.asset(
                "images/lottie/checker.json",
              ),
              Text(
                "Great job on crushing your workout! You’re one step closer to reaching your fitness goals!",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: GlobalThemedata().lightThemeData,
      darkTheme: GlobalThemedata().darkThemeData,
      home: frontView,
    );
  }
}
