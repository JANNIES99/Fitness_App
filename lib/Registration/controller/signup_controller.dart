// ignore_for_file: use_build_context_synchronously, avoid_print

//import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:fitness_loginpage/view/login/login_view.dart';
import 'package:fitnessapp/Registration/view/profile.dart';
//import 'package:fitness_loginpage/view/login/profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<void> createAccount({
    required String email,
    required String password,
    required String fname,
    required String lname,
    required BuildContext context,
  }) async {
    try {
      // Attempt to create a new user
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      var userId = FirebaseAuth.instance.currentUser!.uid;

      var db = FirebaseFirestore.instance;

      Map<String, dynamic> data = {
        "first_name": fname,
        "last_name": lname,
        "email": email,
        "id": userId.toString(),
      };

      try {
        await db.collection("users").doc(userId.toString()).set(data);
      } catch (e) {
        print(e);
      }
      // Check if the user was created successfully
      if (userCredential.user != null) {
        SnackBar messageSnackBar = const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Account Created Successfully"),
        );
        ScaffoldMessenger.of(context).showSnackBar(messageSnackBar);

        // Redirect to CompleteProfileView
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => CompleteProfileView(
                    gmail: email,
                  )),
          (route) => false, // Remove all previous routes from the stack
        );
        print("Account created successfully");
      }
    } catch (e) {
      // Show error message if registration fails
      SnackBar messageSnackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(e.toString()),
      );

      ScaffoldMessenger.of(context).showSnackBar(messageSnackBar);
      print("Signup failed: $e");
    }
  }

  signInWithGoogle() async {
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // user cancels
    if (gUser == null) return;

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }
}
//google_sign_in
