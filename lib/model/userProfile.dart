import 'dart:typed_data';

import 'package:fitnessapp/functions/dateTime.dart';

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
  Map<String, int> exerciseIndex;
}

UserProfile user = UserProfile(
  gmail: "hello@gmail.com",
  firstName: "Jack",
  lastName: "Miller",
  streak: 0,
  gender: "Male",
  height: 1.73,
  weight: 70,
  dob: endOfTheDay(DateTime.now()),
  exerciseIndex: {
    "FULLBODY": 0,
    "ABS": 0,
    "ARMS": 0,
    "CHEST": 0,
    "BACK": 0,
    "LEGS": 0,
  },
);
