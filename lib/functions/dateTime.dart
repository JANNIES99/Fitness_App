DateTime findSunday(DateTime dateTime) {
  int daysToSubtract = (dateTime.weekday == 7) ? 0 : dateTime.weekday;
  return dateTime.subtract(Duration(days: daysToSubtract));
}

DateTime findMonday(DateTime dateTime) {
  int daysToSubtract = (dateTime.weekday == 7) ? 0 : dateTime.weekday - 1;
  return dateTime.subtract(Duration(days: daysToSubtract));
}

DateTime findTuesday(DateTime dateTime) {
  int daysToSubtract = (dateTime.weekday == 7) ? 0 : dateTime.weekday - 2;
  return dateTime.subtract(Duration(days: daysToSubtract));
}

DateTime findWednesday(DateTime dateTime) {
  int daysToSubtract = (dateTime.weekday == 7) ? 0 : dateTime.weekday - 3;
  return dateTime.subtract(Duration(days: daysToSubtract));
}

DateTime findThursday(DateTime dateTime) {
  int daysToSubtract = (dateTime.weekday == 7) ? 0 : dateTime.weekday - 4;
  return dateTime.subtract(Duration(days: daysToSubtract));
}

DateTime findFriday(DateTime dateTime) {
  int daysToSubtract = (dateTime.weekday == 7) ? 0 : dateTime.weekday - 5;
  return dateTime.subtract(Duration(days: daysToSubtract));
}

DateTime findSaturday(DateTime dateTime) {
  int daysToSubtract = (dateTime.weekday == 7) ? 0 : dateTime.weekday - 6;
  return dateTime.subtract(Duration(days: daysToSubtract));
}
