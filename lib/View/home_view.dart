import 'package:fitnessapp/Service/Database.dart';
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
  final DatabaseService _databaseService = DatabaseService.instance;
  final Map<DateTime, double> allDaysWorked = {};

  void setAllDaysWorked() async {
    final map = await _databaseService.getAllDaysWorked();
    setState(() {
      for (final i in map.keys) {
        allDaysWorked[i] = map[i]!;
      }
      for (final i in daysWorked.keys) {
        if (map[i] != null) {
          daysWorked[i] = [true, map[i]!];
        }
      }
      burnedCalories = setBurnedCalories(daysWorked);
    });
  }

  void goToHome() {
    Navigator.of(context).pop();
  }

  List<double> setBurnedCalories(Map<DateTime, List<Object>> caloriesBurned) {
    List<double> list = [];
    for (final calories in caloriesBurned.values) {
      list.add(calories[1] as double);
    }
    return list;
  }

  void workedToday(double caloriesBurned) {
    setState(() {
      streaks++;
      if (daysWorked[endOfTheDay(DateTime.now())]![0] as bool) {
        _databaseService.updateDaysWorked(
            endOfTheDay(DateTime.now()), caloriesBurned);
      } else {
        _databaseService.addToDaysWorked(
            endOfTheDay(DateTime.now()), caloriesBurned);
      }
      List<Object> list = [true, caloriesBurned];
      daysWorked[endOfTheDay(DateTime.now())] = list;
      burnedCalories = setBurnedCalories(daysWorked);
      allDaysWorked[endOfTheDay(DateTime.now())] = caloriesBurned;
    });
  }

  List<double> burnedCalories = [];
  @override
  void initState() {
    setState(() {
      setAllDaysWorked();
    });
    super.initState();
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ExerciseListView(
                      exercises: absExercise[absEasyDayIndex],
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
