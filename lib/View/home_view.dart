import 'package:fitnessapp/View/Exercise_List_View.dart';
import 'package:fitnessapp/Widget/chart/chart.dart';
import 'package:fitnessapp/functions/dateTime.dart';
import 'package:fitnessapp/functions/globalVariables.dart';
import 'package:fitnessapp/model/allExercisePlain.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int streaks = 0;

  void goToHome() {
    Navigator.of(context).pop();
  }

  void workedToday(double caloriesBurned) {
    setState(() {
      streaks++;
      List<Object> list = [true, caloriesBurned];
      daysWorked[endOfTheDay(DateTime.now())] = list;
      burnedCalories[4] = 0.6;
    });
  }

  List<double> burnedCalories = [0.25, 0, 0, 0, 0, 0, 0];
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
                              color: daysWorked[days]![0] as bool
                                  ? Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer
                                  : Theme.of(context).colorScheme.onSecondary,
                              borderRadius: BorderRadius.circular(20)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              (days.day.toString()),
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
          Chart(burnedCalories: burnedCalories),
          Container(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                print(daysWorked);
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
