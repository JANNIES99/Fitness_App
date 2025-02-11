import 'dart:typed_data';

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
