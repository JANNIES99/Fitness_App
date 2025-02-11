import 'package:fitnessapp/functions/dateTime.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {
  Calender({required Map<DateTime, double>? DaysWorked, super.key})
      : allDaysWorked = DaysWorked != null
            ? DaysWorked.entries.isEmpty
                ? null
                : DaysWorked
            : null;
  final Map<DateTime, double>? allDaysWorked;

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    Map<DateTime, double>? allDaysWorked =
        widget.allDaysWorked == {} || widget.allDaysWorked == null
            ? null
            : widget.allDaysWorked;
    List<DateTime>? _highlightedDates;
    if (allDaysWorked == null) {
      _highlightedDates = null;
    } else {
      _highlightedDates = allDaysWorked.keys.toList();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calender"),
      ),
      body: Container(
        child: TableCalendar(
            headerStyle: const HeaderStyle(
                formatButtonVisible: false, titleCentered: true),
            focusedDay: endOfTheDay(DateTime.now()),
            firstDay: allDaysWorked != null
                ? earliestDate((allDaysWorked.keys).toList())
                : endOfTheDay(DateTime.now()),
            lastDay: endOfTheDay(DateTime.now()),
            calendarBuilders: _highlightedDates != null
                ? CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      for (DateTime d in _highlightedDates!) {
                        if (d.day == day.day &&
                            d.month == day.month &&
                            d.year == day.year) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(100)),
                            child: Center(
                              child: Text("${d.day}"),
                            ),
                          );
                        }
                      }
                      return null;
                    },
                  )
                : const CalendarBuilders()),
      ),
    );
  }
}
