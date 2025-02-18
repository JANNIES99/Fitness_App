// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:fitnessapp/Registration/view/login_view.dart';
import 'package:flutter/material.dart';
import '../common/color_extention.dart';
//import '../../common_widget/round_button.dart';
//import '../main_tab/main_tab_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  var user = FirebaseAuth.instance.currentUser;
//   var db = FirebaseFirestore.instance;

//   Future<String?> getFirstName(String userId) async {
//   try {
//     DocumentSnapshot userDoc =
//         await FirebaseFirestore.instance.collection('users').doc(userId).get();

//     if (userDoc.exists) {
//       var fname= userDoc['fname']; // Assuming 'first_name' is the field name
//     } else {
//       print('User not found');
//       return null;
//     }
//   } catch (e) {
//     print('Error fetching user: $e');
//     return null;
//   }
// }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SafeArea(
        child: Container(
          width: media.width,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: media.width * 0.1,
              ),
              Image.asset(
                "assets/images/welcome.png",
                width: media.width * 0.75,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(
                height: media.width * 0.1,
              ),
              Text(
                "Welcome",
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                (user?.email ?? "").toString(),
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: media.width * 0.1,
              ),
              Text(
                "You are all set now, let’s reach your\ngoals together with us",
                textAlign: TextAlign.center,
                style: TextStyle(color: TColor.gray, fontSize: 15),
              ),

              SizedBox(
                height: media.width * 0.1,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();

                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginView();
                      // ignore: avoid_types_as_parameter_names
                    }), (Route) {
                      return false;
                    });
                  },
                  child: Text("Logout")),
              const Spacer(),

              //        RoundButton(
              //           title: "Go To Home",
              //           onPressed: () {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => const MainTabView()));
              //           }),
            ],
          ),
        ),
      ),
    );
  }
}
