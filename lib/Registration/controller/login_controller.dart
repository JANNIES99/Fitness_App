import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/Registration/view/profile.dart';
import 'package:flutter/material.dart';

class LoginController {
  static Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      SnackBar messageSnackBar = const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Logged in successfully"),
      );
      ScaffoldMessenger.of(context).showSnackBar(messageSnackBar);

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return CompleteProfileView(
          gmail: email,
        );
      }), (route) {
        return false;
      });

      print("Logged in successfully");
    } catch (e) {
      SnackBar messageSnackBar = const SnackBar(
        backgroundColor: Colors.red,
        content: Text("Invalid Email or Password"),
      );

      ScaffoldMessenger.of(context).showSnackBar(messageSnackBar);
      print("Login failed: $e");
    }
  }
}
