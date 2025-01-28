import 'package:fitnessapp/functions/dateTime.dart';

final List<int> daysOfTheWeek = [
  findSunday(DateTime.now()).day,
  findMonday(DateTime.now()).day,
  findTuesday(DateTime.now()).day,
  findWednesday(DateTime.now()).day,
  findThursday(DateTime.now()).day,
  findFriday(DateTime.now()).day,
  findSaturday(DateTime.now()).day,
];
