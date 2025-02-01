import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

DateFormat format = DateFormat('MM/dd/yyyy');

class DatabaseService {
  Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();
  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await getDataBase();
    return _db!;
  }

  final _tableName1 = "Streak";

  Future<Database> getDataBase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "Expense_db.db");
    final database = await openDatabase(
      databasePath,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE $_tableName1(DATES TEXT PRIMARY KEY,CALORIES REAL)');
      },
      version: 1,
    );
    return database;
  }
}
