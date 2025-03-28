import 'dart:typed_data';

import 'package:fitnessapp/functions/dateTime.dart';
import 'package:fitnessapp/model/userProfile.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final DateFormat format = DateFormat('MM/dd/yyyy');
final DateFormat formatter = DateFormat.yMd();

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

  final _tableName1 = "DaysWorked";
  final _tableName2 = "Profile";
  Future<Database> getDataBase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "Exercise3_db.db");
    final database = await openDatabase(
      databasePath,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE $_tableName1(DATES TEXT PRIMARY KEY,CALORIES REAL)');
        db.execute(
            'CREATE TABLE $_tableName2(GMAIL TEXT PRIMARY KEY,FIRSTNAME TEXT,LASTNAME TEXT,IMAGE BLOB,EXPERIENCE INTEGER,GENDER TEXT,DOB TEXT,WEIGHT REAL,HEIGHT REAL,STREAKS INTEGER,FULLBODY INTEGER,ABS INTEGER,ARMS INTEGER,CHEST INTEGER,BACK INTEGER,LEGS INTEGER,YOGA INTEGER)');
      },
      version: 1,
    );
    return database;
  }

  void addToDaysWorked(DateTime date, double calorie) async {
    Map<String, Object> map = {
      "DATES": formatter.format(date),
      "CALORIES": calorie,
    };
    final db = await database;
    db.insert(_tableName1, map);
  }

  void updateDaysWorked(DateTime date, double calorie) async {
    final db = await database;
    Map<String, Object> map = {
      "CALORIES": calorie,
    };
    db.update(_tableName1, map,
        where: "DATES = ?", whereArgs: [formatter.format(date)]);
  }

  Future<Map<DateTime, double>> getAllDaysWorked() async {
    Map<DateTime, double> map = {};
    final db = await database;
    final datas = await db.query(_tableName1);
    for (final data in datas) {
      map[endOfTheDay(format.parse(data["DATES"] as String))] =
          data["CALORIES"] as double;
    }
    return map;
  }

  void deleteAllDaysWorked() async {
    final db = await database;
    db.delete(_tableName1);
  }

  void addToProfile(UserProfile userInfo) async {
    Map<String, Object> map = {
      "GMAIL": userInfo.gmail,
      "FIRSTNAME": userInfo.firstName,
      "LASTNAME": userInfo.lastName,
      "GENDER": userInfo.gender,
      "DOB": formatter.format(userInfo.dob),
      "HEIGHT": userInfo.height,
      "WEIGHT": userInfo.weight,
      "STREAKS": userInfo.streak,
      "EXPERIENCE": userInfo.experience,
      "FULLBODY": userInfo.exerciseIndex["FULLBODY"]!,
      "ABS": userInfo.exerciseIndex["ABS"]!,
      "ARMS": userInfo.exerciseIndex["ARMS"]!,
      "CHEST": userInfo.exerciseIndex["CHEST"]!,
      "BACK": userInfo.exerciseIndex["BACK"]!,
      "LEGS": userInfo.exerciseIndex["LEGS"]!,
      "YOGA": userInfo.exerciseIndex["YOGA"]!,
    };
    if (userInfo.image != null) {
      map["IMAGE"] = userInfo.image!;
    }
    print(map);
    final db = await database;
    db.insert(_tableName2, map);
  }

  Future<UserProfile?> getUserProfile() async {
    final db = await database;
    final datas = await db.query(_tableName2);
    final data = datas[0];
    print(data);
    UserProfile? userData = UserProfile(
      gmail: data["GMAIL"] as String,
      firstName: data["FIRSTNAME"] as String,
      lastName: data["LASTNAME"] as String,
      streak: data["STREAKS"] as int,
      image: data["IMAGE"] as Uint8List?,
      gender: data["GENDER"] as String,
      height: data["HEIGHT"] as double,
      weight: data["WEIGHT"] as double,
      experience: data["EXPERIENCE"] as int,
      dob: format.parse(data["DOB"] as String),
      exerciseIndex: {
        "FULLBODY": data["FULLBODY"] as int,
        "ABS": data["ABS"] as int,
        "ARMS": data["ARMS"] as int,
        "CHEST": data["CHEST"] as int,
        "BACK": data["BACK"] as int,
        "LEGS": data["LEGS"] as int,
        "YOGA": data["YOGA"] as int,
      },
    );
    print(userData.exerciseIndex);
    return userData;
  }

  void updateUserProfile(UserProfile userInfo) async {
    final db = await database;
    Map<String, Object> map = {
      "FIRSTNAME": userInfo.firstName,
      "LASTNAME": userInfo.lastName,
      "GENDER": userInfo.gender,
      "DOB": formatter.format(userInfo.dob),
      "HEIGHT": userInfo.height,
      "WEIGHT": userInfo.weight,
      "STREAKS": userInfo.streak,
      "EXPERIENCE": userInfo.experience,
      "FULLBODY": userInfo.exerciseIndex["FULLBODY"]!,
      "ABS": userInfo.exerciseIndex["ABS"]!,
      "ARMS": userInfo.exerciseIndex["ARMS"]!,
      "CHEST": userInfo.exerciseIndex["CHEST"]!,
      "BACK": userInfo.exerciseIndex["BACK"]!,
      "LEGS": userInfo.exerciseIndex["LEGS"]!,
      "YOGA": userInfo.exerciseIndex["YOGA"]!,
    };
    if (userInfo.image != null) {
      map["IMAGE"] = userInfo.image!;
    }
    db.update(_tableName2, map,
        where: "GMAIL = ?", whereArgs: [userInfo.gmail]);
  }

  void deleteUserProfile(UserProfile userInfo) async {
    final db = await database;
    db.delete(_tableName2, where: "GMAIL = ?", whereArgs: [userInfo.gmail]);
  }
}
