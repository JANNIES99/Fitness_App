import 'package:fitnessapp/functions/dateTime.dart';

int absEasyDayIndex = 0;

final Map<DateTime, List<Object>> daysWorked = {
  findSunday(DateTime.now()): [true, 0.3],
  findMonday(DateTime.now()): [false, 0.0],
  findTuesday(DateTime.now()): [false, 0.0],
  findWednesday(DateTime.now()): [false, 0.0],
  findThursday(DateTime.now()): [false, 0.0],
  findFriday(DateTime.now()): [false, 0.0],
  findSaturday(DateTime.now()): [false, 0.0],
};
