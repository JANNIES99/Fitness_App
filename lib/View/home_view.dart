import 'package:fitnessapp/Service/Database.dart';
import 'package:fitnessapp/View/Calender.dart';
import 'package:fitnessapp/Widget/chart/chart.dart';
import 'package:fitnessapp/Widget/typesOfExercise.dart';
import 'package:fitnessapp/functions/dateTime.dart';
import 'package:fitnessapp/functions/globalVariables.dart';
import 'package:fitnessapp/model/ExercisePlain/absExercisePlain.dart';
import 'package:fitnessapp/model/ExercisePlain/armExercisePlain.dart';
import 'package:fitnessapp/model/ExercisePlain/fullBodyExercisePlain.dart';
import 'package:fitnessapp/model/userProfile.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({required this.user, super.key});
  final UserProfile user;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DatabaseService _databaseService = DatabaseService.instance;
  final Map<DateTime, double> allDaysWorked = {};
  double buff = 0;
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
      if (allDaysWorked.entries.isNotEmpty) {
        final DateTime date = latestDate(allDaysWorked.keys.toList());
        final DateTime day = endOfTheDay(DateTime.now());
        if (date.day >= day.day - 1 &&
            date.month == day.month &&
            date.year == day.year) {
        } else {
          widget.user.streak = 0;
        }
      }
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

  void workedToday(double caloriesBurned, String exercise) {
    setState(() {
      if (allDaysWorked.entries.isNotEmpty) {
        final DateTime date = latestDate(allDaysWorked.keys.toList());
        final DateTime day = endOfTheDay(DateTime.now());
        if (date.day <= day.day - 1 &&
            date.month == day.month &&
            date.year == day.year) {
          widget.user.streak++;
        }
      } else {
        widget.user.streak++;
      }
      widget.user.exerciseIndex[exercise] =
          widget.user.exerciseIndex[exercise]! + 1;
      _databaseService.updateUserProfile(widget.user);
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
      double weightclass =
          widget.user.weight / (widget.user.height * widget.user.height);
      if (weightclass <= 18.5) {
        buff += -0.1;
      }
      if (weightclass >= 30) {
        buff += -0.3;
      } else if (weightclass >= 25) {
        buff += -0.2;
      }
      buff += widget.user.experience * 0.05;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fitness App",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Calender(
                          DaysWorked: allDaysWorked,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Theme.of(context).cardColor,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.calendar_month_outlined),
                                const SizedBox(width: 5),
                                Text(
                                  "Weekly goals",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.local_fire_department,
                                color: Colors.deepOrange,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "${widget.user.streak} days streak",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
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
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      (days.day.toString()),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
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
                ),
              ),
              Chart(burnedCalories: burnedCalories),
              Typesofexercises(
                exercise: "FULLBODY",
                exercises: fullBodyExercise,
                goBackHome: goToHome,
                workedToday: workedToday,
                buff: buff,
                exerciseIndex: widget.user.exerciseIndex["FULLBODY"]!,
              ),
              Typesofexercises(
                exercise: "ARMS",
                exercises: armBodyExercise,
                goBackHome: goToHome,
                workedToday: workedToday,
                buff: buff,
                exerciseIndex: widget.user.exerciseIndex["ARMS"]!,
              ),
              Typesofexercises(
                exercise: "ABS",
                exercises: absExercise,
                goBackHome: goToHome,
                workedToday: workedToday,
                buff: buff,
                exerciseIndex: widget.user.exerciseIndex["ABS"]!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
