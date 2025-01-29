import 'package:fitnessapp/functions/dateTime.dart';

int absEasyDayIndex = 0;

final Map<int, bool> daysWorked = {
  findSunday(DateTime.now()).day: true,
  findMonday(DateTime.now()).day: false,
  findTuesday(DateTime.now()).day: false,
  findWednesday(DateTime.now()).day: false,
  findThursday(DateTime.now()).day: false,
  findFriday(DateTime.now()).day: false,
  findSaturday(DateTime.now()).day: false,
};
