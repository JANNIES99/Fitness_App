// ignore_for_file: deprecated_member_use

import 'package:fitnessapp/Registration/common_widget/round_button.dart';
import 'package:fitnessapp/Registration/common_widget/round_textfield.dart';
import 'package:fitnessapp/Registration/controller/login_controller.dart';
// ignore: unused_import
import 'package:fitnessapp/Registration/view/profile.dart';
import 'package:fitnessapp/Registration/view/signup_view.dart';
import 'package:flutter/material.dart';

import '../common/color_extention.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isHidden = true;
  IconData hiddenIcon = Icons.remove_red_eye_outlined;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: media.height * 0.9,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: media.width * 0.04,
                ),
                Text(
                  "Hey there,",
                  style: TextStyle(color: TColor.gray, fontSize: 16),
                ),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  controller: email,
                  hitText: "Email",
                  icon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  controller: password,
                  hitText: "Password",
                  icon: Icons.lock_outline_rounded,
                  obscureText: isHidden,
                  rigtIcon: TextButton(
                      onPressed: () {
                        setState(() {
                          if (isHidden) {
                            hiddenIcon = Icons.remove_red_eye_rounded;
                            isHidden = !isHidden;
                          } else {
                            hiddenIcon = Icons.remove_red_eye_outlined;
                            isHidden = !isHidden;
                          }
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        child: Icon(hiddenIcon),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: media.width * 0.09,
                    ),
                    Text(
                      "Forgot your password?",
                      style: TextStyle(
                          color: TColor.gray,
                          fontSize: 10,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
                const Spacer(),
                RoundButton(
                  title: "Login",
                  icon: "assets/images/Login.png",
                  onPressed: () {
                    {
                      LoginController.login(
                          email: email.text,
                          password: password.text,
                          context: context);
                    }
                  },
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    Expanded(
                        child: Container(
                      height: 1,
                      color: TColor.gray.withOpacity(0.5),
                    )),
                    Text(
                      "  Or  ",
                      style: TextStyle(color: TColor.black, fontSize: 12),
                    ),
                    Expanded(
                        child: Container(
                      height: 1,
                      color: TColor.gray.withOpacity(0.5),
                    )),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: TColor.white,
                          border: Border.all(
                            width: 1,
                            color: TColor.gray.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(
                          "images/Registration/google.png",
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Container(
                    //     width: 50,
                    //     height: 50,
                    //     alignment: Alignment.center,
                    //     decoration: BoxDecoration(
                    //       color: TColor.white,
                    //       border: Border.all(
                    //         width: 1,
                    //         color: TColor.gray.withOpacity(0.4),
                    //       ),
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     // child: Image.asset(
                    //     //   "assets/images/facebook.png",
                    //     //   width: 50,
                    //     //   height: 50,
                    //     // ),
                    //   ),
                    // )
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don’t have an account yet? ",
                        style: TextStyle(
                          color: TColor.black,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: TColor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpView()));
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
