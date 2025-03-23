import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/Registration/view/profile.dart';
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
      if (userCredential.user != null) {
        SnackBar messageSnackBar = const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Account Created Successfully"),
        );
        ScaffoldMessenger.of(context).showSnackBar(messageSnackBar);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => CompleteProfileView(
                    gmail: email,
                    firstName: fname,
                    lastName: lname,
                  )),
          (route) => false,
        );
        print("Account created successfully");
      }
    } catch (e) {
      SnackBar messageSnackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(e.toString()),
      );

      ScaffoldMessenger.of(context).showSnackBar(messageSnackBar);
      print("Signup failed: $e");
    }
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    if (gUser == null) return;

    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }
}
