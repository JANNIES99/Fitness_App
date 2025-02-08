DateTime findSunday(DateTime dateTime) {
  int daysToSubtract = (dateTime.weekday == 7) ? 0 : dateTime.weekday;
  return endOfTheDay(dateTime).subtract(Duration(days: daysToSubtract));
}

DateTime findMonday(DateTime dateTime) {
  int daysToSubtract = (dateTime.weekday == 7) ? -1 : dateTime.weekday - 1;
  return endOfTheDay(dateTime).subtract(Duration(days: daysToSubtract));
}

DateTime findTuesday(DateTime dateTime) {
  int daysToSubtract = (dateTime.weekday == 7) ? -2 : dateTime.weekday - 2;
  return endOfTheDay(dateTime).subtract(Duration(days: daysToSubtract));
}

DateTime findWednesday(DateTime dateTime) {
  int daysToSubtract = (dateTime.weekday == 7) ? -3 : dateTime.weekday - 3;
  return endOfTheDay(dateTime).subtract(Duration(days: daysToSubtract));
}

DateTime findThursday(DateTime dateTime) {
  int daysToSubtract = (dateTime.weekday == 7) ? -4 : dateTime.weekday - 4;
  return endOfTheDay(dateTime).subtract(Duration(days: daysToSubtract));
}

DateTime findFriday(DateTime dateTime) {
  int daysToSubtract = (dateTime.weekday == 7) ? -5 : dateTime.weekday - 5;
  return endOfTheDay(dateTime).subtract(Duration(days: daysToSubtract));
}

DateTime findSaturday(DateTime dateTime) {
  int daysToSubtract = (dateTime.weekday == 7) ? -6 : dateTime.weekday - 6;
  return endOfTheDay(dateTime).subtract(Duration(days: daysToSubtract));
}

DateTime endOfTheDay(DateTime dateTime) {
  DateTime now = dateTime;
  DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
  return endOfDay;
}

DateTime earliestDate(List<DateTime> listOfDates) {
  DateTime lowestDate = listOfDates.reduce((a, b) => a.isBefore(b) ? a : b);
  return lowestDate;
}
