// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neoroo_app/models/infant_model.dart';
import 'package:neoroo_app/screens/skin_to_skin_time/edit_dialog.dart';


class LinearCalendarWidget extends StatefulWidget {
  final Infant infant;
  const LinearCalendarWidget({
    Key? key,
    required this.infant,
  }) : super(key: key);
  @override
  _LinearCalendarWidgetState createState() => _LinearCalendarWidgetState();
}

class _LinearCalendarWidgetState extends State<LinearCalendarWidget> {
  DateTime _selectedDate = DateTime.now();

  late int weekNumber;

  void _previousWeek() {
    setState(() {
      weekNumber = weekNumber - 1;
      _selectedDate = _selectedDate.subtract(Duration(days: 7));
    });
  }

  void _nextWeek() {
    setState(() {
      weekNumber = weekNumber + 1;
      _selectedDate = _selectedDate.add(Duration(days: 7));
    });
  }

  int getCurrentWeekNumber() {
    DateTime now = DateTime.now();
    DateTime firstDayOfYear = DateTime(now.year, 1, 1);

    Duration difference = now.difference(firstDayOfYear);
    int daysPassed = difference.inDays;
    int currentWeekNumber = (daysPassed / 7).ceil();

    return currentWeekNumber;
  }

  @override
  void initState() {
    weekNumber = getCurrentWeekNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime firstDayOfCurrentWeek =
        _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${DateFormat('MMMM').format(_selectedDate)} ${DateFormat('y').format(_selectedDate)}",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      showEditGoalDialog(context, widget.infant);
                    },
                    child: Container(
                      width: 70,
                      height: 24,
                      color: Color.fromRGBO(110, 42, 127, 1),
                      child: Center(
                          child: Text(
                        "Edit Goal",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    onTap: _previousWeek,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 15,
                      color: Color.fromRGBO(110, 42, 127, 1),
                    ),
                  ),
                  Text(
                    'Week $weekNumber',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  InkWell(
                    onTap: _nextWeek,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Color.fromRGBO(110, 42, 127, 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(7, (index) {
                  DateTime day =
                      firstDayOfCurrentWeek.add(Duration(days: index));
                  bool isToday = day.isAtSameMomentAs(DateTime.now());
                  return Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: isToday ? Colors.blue : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          day.weekday == DateTime.sunday
                              ? 'S'
                              : day.weekday == DateTime.monday
                                  ? 'M'
                                  : day.weekday == DateTime.tuesday
                                      ? 'T'
                                      : day.weekday == DateTime.wednesday
                                          ? 'W'
                                          : day.weekday == DateTime.thursday
                                              ? 'T'
                                              : day.weekday == DateTime.friday
                                                  ? 'F'
                                                  : 'S',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          day.day.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            color: isToday ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              Positioned(
                top: 45,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Container(
                    height: 1,
                    width: 400,
                    color: Colors.grey.shade400,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}



void showEditGoalDialog(BuildContext context, Infant infant) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
          child: EditDialog(
        infant: infant,
      ));
    },
  );
}

