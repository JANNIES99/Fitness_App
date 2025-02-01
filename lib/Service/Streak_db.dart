import 'package:drift/drift.dart';

class StreakDb extends Table {
  DateTimeColumn get dates => dateTime()();
  IntColumn get caloriesburned => integer()();
}
