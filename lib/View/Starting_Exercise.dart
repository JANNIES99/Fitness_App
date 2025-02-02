import 'package:fitnessapp/View/Break_View.dart';
import 'package:fitnessapp/View/Doing_Exercise.dart';
import 'package:fitnessapp/model/Exercise.dart';
import 'package:fitnessapp/model/Theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StartingExercise extends StatefulWidget {
  const StartingExercise(
      {required this.exercises,
      required this.goBackHome,
      required this.workedToday,
      super.key});
  final List<Exercise> exercises;
  final void Function() goBackHome;
  final void Function(double) workedToday;
  @override
  State<StartingExercise> createState() => _StartingExerciseState();
}

class _StartingExerciseState extends State<StartingExercise> {
  Widget? frontView;
  int selector = -1;
  double caloriesBurned = 0;

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
        caloriesBurned -= widget.exercises[selector].caloriesBurned;
        frontView = DoingExercise(
            switchPrevious: switchToPreviousExercise,
            switchView: switchToBreakView,
            goBack: goBack,
            exercise: widget.exercises[selector]);
      });
    }
  }

  void switchToBreakView() {
    caloriesBurned += widget.exercises[selector].caloriesBurned;
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
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  widget.workedToday(caloriesBurned);
                  Navigator.of(context).pop();
                  goBack();
                  widget.goBackHome();
                },
                child: const Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: GlobalThemedata().lightThemeData,
      darkTheme: GlobalThemedata().darkThemeData,
      home: frontView,
    );
  }
}
