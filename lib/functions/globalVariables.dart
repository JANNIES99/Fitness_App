import 'package:fitnessapp/functions/dateTime.dart';

int absEasyDayIndex = 0;

final Map<DateTime, bool> daysWorked = {
  findSunday(DateTime.now()): true,
  findMonday(DateTime.now()): false,
  findTuesday(DateTime.now()): false,
  findWednesday(DateTime.now()): false,
  findThursday(DateTime.now()): false,
  findFriday(DateTime.now()): false,
  findSaturday(DateTime.now()): false,
};
