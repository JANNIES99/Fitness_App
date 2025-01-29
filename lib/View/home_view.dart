import 'package:fitnessapp/View/Exercise_List_View.dart';
import 'package:fitnessapp/functions/globalVariables.dart';
import 'package:fitnessapp/model/allExercisePlain.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int streaks = 5;

  void goToHome() {
    Navigator.of(context).pop();
  }

  void workedToday() {
    setState(() {
      streaks++;
      daysWorked[DateTime.now().day] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fitness App"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Card(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Weekly goals",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Text(
                    "$streaks days streak",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...daysWorked.keys.map(
                        (days) => Container(
                          margin: const EdgeInsets.all(10),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: daysWorked[days]!
                                  ? Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer
                                  : Theme.of(context).colorScheme.onSecondary,
                              borderRadius: BorderRadius.circular(20)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              (days.toString()),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ExerciseListView(
                      exercises: absEasyExercise[absEasyDayIndex],
                      goBackHome: goToHome,
                      workedToday: workedToday,
                    ),
                  ),
                );
              },
              child: Card(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: 50,
                  child: Image.asset("images/abs.jpg"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
