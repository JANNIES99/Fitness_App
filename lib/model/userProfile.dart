import 'dart:typed_data';

import 'package:fitnessapp/functions/dateTime.dart';
import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat.yMd();

class UserProfile {
  UserProfile({
    required this.gmail,
    required this.firstName,
    required this.lastName,
    required this.streak,
    required this.gender,
    required this.height,
    required this.weight,
    required this.dob,
    required this.experience,
    required this.exerciseIndex,
    this.image,
  });
  final String gmail;
  final String firstName;
  final String lastName;
  int streak;
  Uint8List? image;
  final String gender;
  double height;
  double weight;
  final DateTime dob;
  final int experience;
  Map<String, int> exerciseIndex;

  String get formateedDate => formatter.format(dob);
}

UserProfile defaultUser = UserProfile(
  gmail: "hello@gmail.com",
  firstName: "Jack",
  lastName: "Miller",
  streak: 0,
  gender: "Male",
  height: 1.73,
  weight: 70,
  experience: 3,
  dob: endOfTheDay(DateTime.now()),
  exerciseIndex: {
    "FULLBODY": 0,
    "ABS": 0,
    "ARMS": 0,
    "CHEST": 0,
    "BACK": 0,
    "LEGS": 0,
    "YOGA": 0
  },
);
