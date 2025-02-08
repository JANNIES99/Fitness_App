import 'package:fitnessapp/functions/dateTime.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {
  const Calender({required this.allDaysWorked, super.key});
  final Map<DateTime, double> allDaysWorked;

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calender"),
      ),
      body: Container(
        child: TableCalendar(
            headerStyle: const HeaderStyle(
                formatButtonVisible: false, titleCentered: true),
            focusedDay: endOfTheDay(DateTime.now()),
            firstDay: earliestDate((widget.allDaysWorked.keys).toList()),
            lastDay: endOfTheDay(DateTime.now())),
      ),
    );
  }
}
