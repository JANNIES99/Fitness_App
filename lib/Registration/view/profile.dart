import 'package:fitnessapp/Service/Database.dart';
import 'package:fitnessapp/View/home_view.dart';
import 'package:fitnessapp/model/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_button/group_button.dart';

import '../common/color_extention.dart';
// ignore: unused_import
import '../common_widget/round_button.dart';
import '../common_widget/round_textfield.dart';

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView(
      {required this.gmail, super.key, this.firstName, this.lastName});
  final String gmail;
  final String? firstName;
  final String? lastName;

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  DateTime? _selectedData;
  String displayDate = "Date of Brith";
  String? selectedGender;
  int? experienceValue;

  void registerUser() {
    if ((firstName.text != "" || widget.firstName != null) &&
        (lastName.text != "" || widget.lastName != null) &&
        _selectedData != null &&
        selectedGender != null &&
        experienceValue != null &&
        height.text != "" &&
        weight.text != "") {
      UserProfile user = UserProfile(
        gmail: widget.gmail,
        firstName:
            widget.firstName == null ? firstName.text : widget.firstName!,
        lastName: widget.lastName == null ? lastName.text : widget.lastName!,
        streak: 0,
        gender: selectedGender!,
        height: double.parse(height.text),
        weight: double.parse(weight.text),
        dob: _selectedData!,
        experience: experienceValue!,
        exerciseIndex: {
          "FULLBODY": 0,
          "ABS": 0,
          "ARMS": 0,
          "CHEST": 0,
          "BACK": 0,
          "LEGS": 0,
          "YOGA": 0
        },
      );
      final DatabaseService _databaseService = DatabaseService.instance;
      _databaseService.addToProfile(user);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomeView(user: user);
      }));
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Invalid Input",
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18),
          ),
          content: const Text(
              "Plase make sure you have valid First Name, Last Name, Gender, D.O.B, Weight, Height, and Experience that was entered"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Okay"),
            )
          ],
        ),
      );
      return;
    }
  }

  void _openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 100, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(
      () {
        if (pickedDate != null) {
          _selectedData = pickedDate;
          setState(() {
            displayDate =
                "${_selectedData!.day}/${_selectedData!.month}/${_selectedData!.year}";
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      persistentFooterButtons: [
        RoundButton(
            title: "Next >",
            onPressed: () {
              registerUser();
            }),
      ],
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Image.asset(
                    "images/Registration/wrkt.png",
                    width: media.width,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  Text(
                    "Let’s complete your profile",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "It will help us to know more about you!",
                    style: TextStyle(color: TColor.gray, fontSize: 12),
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Visibility(
                          visible: widget.firstName == null,
                          child: RoundTextField(
                            hitText: "First Name",
                            icon: Icons.person,
                            controller: firstName,
                          ),
                        ),
                        SizedBox(
                          height: media.width * 0.04,
                        ),
                        Visibility(
                          visible: widget.lastName == null,
                          child: RoundTextField(
                            hitText: "Last Name",
                            icon: Icons.person_outline_rounded,
                            controller: lastName,
                          ),
                        ),

                        SizedBox(
                          height: media.width * 0.04,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: TColor.lightGray,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: const Icon(Icons.people)),
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedGender,
                                    items: ["Male", "Female"]
                                        .map((name) => DropdownMenuItem(
                                              value: name,
                                              child: Text(
                                                name,
                                                style: TextStyle(
                                                    color: TColor.gray,
                                                    fontSize: 14),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGender =
                                            value; // Update the selected value
                                      });
                                    },
                                    isExpanded: true,
                                    hint: Text(
                                      "Choose Gender",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: media.width * 0.04,
                        ),
                        GestureDetector(
                          onTap: () {
                            _openDatePicker();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                color: TColor.lightGray,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: const Icon(
                                        Icons.calendar_month_outlined)),
                                Text(displayDate,
                                    style:
                                        Theme.of(context).textTheme.labelSmall),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: media.width * 0.04,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RoundTextField(
                                hitText: "Your Weight",
                                icon: Icons.monitor_weight_rounded,
                                inputFormat: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*'))
                                ],
                                // keyboardType:
                                //     const TextInputType.numberWithOptions(
                                //         decimal: true),
                                controller: weight,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: TColor.secondaryG,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                "KG",
                                style: TextStyle(
                                    color: TColor.white, fontSize: 12),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: media.width * 0.04,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RoundTextField(
                                hitText: "Your Height",
                                icon: Icons.swap_vert_rounded,
                                inputFormat: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*'))
                                ],
                                // keyboardType:
                                //     const TextInputType.numberWithOptions(
                                //         decimal: true),
                                controller: height,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: TColor.secondaryG,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                "M",
                                style: TextStyle(
                                    color: TColor.white, fontSize: 12),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: media.width * 0.04,
                        ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       color: TColor.lightGray,
                        //       borderRadius: BorderRadius.circular(15)),
                        //   child: Row(
                        //     children: [
                        //       for (int i = 1; i <= 10; i++)
                        //         Container(
                        //           margin: const EdgeInsets.all(10),
                        //           height: 15,
                        //           width: 15,
                        //           decoration: BoxDecoration(
                        //               color: Theme.of(context)
                        //                   .colorScheme
                        //                   .onSecondary,
                        //               borderRadius: BorderRadius.circular(20)),
                        //           child: Align(
                        //             alignment: Alignment.center,
                        //             child: Text((i.toString()),
                        //                 style: const TextStyle(
                        //                     color: Colors.black, fontSize: 10)),
                        //           ),
                        //         ),
                        //     ],
                        //   ),
                        // )
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: TColor.lightGray,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.fitness_center,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Rate your exercise background",
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GroupButton(
                                isRadio: true,
                                onSelected: (value, index, isSelected) =>
                                    experienceValue = int.parse(value),
                                buttons: const [
                                  "1",
                                  "2",
                                  "3",
                                  "4",
                                  "5",
                                  "6",
                                  "7",
                                  "8",
                                  "9",
                                  "10",
                                ],
                                buttonBuilder: (selected, value, context) =>
                                    Container(
                                  margin: const EdgeInsets.all(10),
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: selected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text((value),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
