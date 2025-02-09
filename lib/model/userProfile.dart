import 'dart:typed_data';

class Userprofile {
  Userprofile({
    required this.gmail,
    required this.firstName,
    required this.lastName,
    required this.streak,
    required this.gender,
    this.image,
  });
  final String gmail;
  final String firstName;
  final String lastName;
  int streak;
  Uint8List? image;
  final String gender;
  int FIRSTNAME TEXT,LASTNAME TEXT,IMAGE BLOB,GENDER TEXT,DOB TEXT,WEIGHT REAL,HEIGHT REAL,STREAKS INTEGER,FULLBODY INTEGER,ABS INTEGER,ARMS INTEGER,CHEST INTEGER,BACK INTEGER,LEGS INTEGER

}