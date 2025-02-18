import 'package:fitnessapp/model/userProfile.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({required this.userData, super.key});
  final UserProfile userData;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.userData.firstName,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
