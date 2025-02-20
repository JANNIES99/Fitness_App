import 'package:fitnessapp/Registration/view/goal.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import '../common/color_extention.dart';
// ignore: unused_import
import '../common_widget/round_button.dart';
import '../common_widget/round_textfield.dart';

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({super.key});

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  TextEditingController txtDate = TextEditingController();
  DateTime? _selectedData = DateTime.now();
  String displayDate = "Date of Brith";
  String? selectedGender;
  int experienceValue = 0;

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WhatYourGoalView()));
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
                                      style: TextStyle(
                                          color: TColor.gray, fontSize: 12),
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
                        RoundTextField(
                          controller: txtDate,
                          hitText: displayDate,
                          icon: Icons.calendar_today_rounded,
                          rigtIcon: IconButton(
                              onPressed: () {
                                _openDatePicker();
                              },
                              icon: const Icon(Icons.calendar_month_outlined)),
                        ),
                        SizedBox(
                          height: media.width * 0.04,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              child: RoundTextField(
                                hitText: "Your Weight",
                                icon: Icons.monitor_weight_rounded,
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
                            const Expanded(
                              child: RoundTextField(
                                hitText: "Your Height",
                                icon: Icons.swap_vert_rounded,
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
                          height: media.width * 0.07,
                        ),
                        const Text("What is your experience with exercise"),
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
                          margin: EdgeInsets.all(media.width * 0.04),
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: TColor.lightGray,
                              borderRadius: BorderRadius.circular(15)),
                          child: GroupButton(
                            isRadio: true,
                            onSelected: (value, index, isSelected) =>
                                experienceValue = int.parse(value),
                            buttons: const [
                              "0",
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
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text((value),
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ),
                            ),
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
