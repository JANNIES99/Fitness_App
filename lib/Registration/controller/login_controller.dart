// ignore_for_file: use_build_context_synchronously, avoid_print

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
      // Attempt sign-in
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      SnackBar messageSnackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text("Logged in successfully"),
      );
      ScaffoldMessenger.of(context).showSnackBar(messageSnackBar);

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return CompleteProfileView();
      }), (route) {
        return false;
      } // Remove all previous routes from the stack
          );

      print("Logged in successfully");
    } catch (e) {
      // Show error message
      SnackBar messageSnackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text("Invalid Email or Password"),
      );

      ScaffoldMessenger.of(context).showSnackBar(messageSnackBar);
      print("Login failed: $e");
    }
  }
}
