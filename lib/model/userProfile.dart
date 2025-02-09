import 'dart:typed_data';

class Userprofile {
  Userprofile({
    required this.gmail,
    required this.firstName,
    required this.lastName,
    required this.streak,
    required this.gender,
    required this.height,
    required this.weight,
    required this.dob,
    required this.fullBodyIndex,
    required this.absIndex,
    required this.armsIndex,
    required this.backIndex,
    required this.chestIndex,
    required this.legsIndex,
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
  int fullBodyIndex;
  int absIndex;
  int armsIndex;
  int chestIndex;
  int backIndex;
  int legsIndex;
}
