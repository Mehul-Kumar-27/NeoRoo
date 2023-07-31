import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:neoroo_app/bloc/update_baby_bloc/update_baby_bloc.dart';
import 'package:neoroo_app/bloc/update_baby_bloc/update_baby_events.dart';
import 'package:neoroo_app/bloc/update_baby_bloc/update_baby_states.dart';
import 'package:neoroo_app/models/infant_model.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:neoroo_app/utils/custom_loader.dart';

class EditDialog extends StatefulWidget {
  final Infant infant;
  const EditDialog({
    Key? key,
    required this.infant,
  }) : super(key: key);

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  TimePeriodSelected? timePeriodSelected = TimePeriodSelected.Daily;
  TextEditingController hoursControllerForDaily = TextEditingController();
  TextEditingController minutesControllerForDaily = TextEditingController();
  TextEditingController hoursControllerForWeekly = TextEditingController();
  TextEditingController minutesControllerForWeekly = TextEditingController();
  TextEditingController hoursControllerForMonthly = TextEditingController();
  TextEditingController minutesControllerForMonthly = TextEditingController();
  void showSnackbarError(String message) {
    SnackBar snackBar = SnackBar(
      backgroundColor: red,
      content: Text(
        message,
        style: TextStyle(
          color: white,
          fontFamily: openSans,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSnackbarSuccess(String message) {
    SnackBar snackBar = SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        message,
        style: TextStyle(
          color: white,
          fontFamily: openSans,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  initializeControllersForDifferentPeriod() {
    if (widget.infant.goals == "Dummy" || widget.infant.goals.isEmpty) {
      setState(() {
        hoursControllerForDaily.text = "0";
        hoursControllerForMonthly.text = "0";
        hoursControllerForWeekly.text = "0";

        minutesControllerForDaily.text = "0";
        minutesControllerForWeekly.text = "0";
        minutesControllerForMonthly.text = "0";
      });
    } else {
      Map<dynamic, dynamic> infantGoals = jsonDecode(widget.infant.goals);
      for (var key in infantGoals.keys) {
        if (key == "Daily") {
          print(key);
          String hrsOfThisKey = infantGoals[key][0]["hrs"];
          String minsOfThisKey = infantGoals[key][1]["min"];
          setState(() {
            hoursControllerForDaily.text = hrsOfThisKey;
            minutesControllerForDaily.text = minsOfThisKey;
          });

          print(hoursControllerForDaily.text);
          print(minutesControllerForDaily.text);
        } else if (key == "Weekly") {
          print(key);
          String hrsOfThisKey = infantGoals[key][0]["hrs"];
          String minsOfThisKey = infantGoals[key][1]["min"];
          setState(() {
            hoursControllerForWeekly.text = hrsOfThisKey;
            minutesControllerForWeekly.text = minsOfThisKey;
          });
        } else if (key == "Monthly") {
          print(key);
          String hrsOfThisKey = infantGoals[key][0]["hrs"];
          String minsOfThisKey = infantGoals[key][1]["min"];
          setState(() {
            hoursControllerForMonthly.text = hrsOfThisKey;
            minutesControllerForMonthly.text = minsOfThisKey;
          });
        }
      }
    }
  }

  TextEditingController hoursControllerSelected() {
    if (timePeriodSelected == TimePeriodSelected.Daily) {
      return hoursControllerForDaily;
    } else if (timePeriodSelected == TimePeriodSelected.Weekly) {
      return hoursControllerForWeekly;
    } else {
      return hoursControllerForMonthly;
    }
  }

  TextEditingController minuteControllerSelected() {
    if (timePeriodSelected == TimePeriodSelected.Daily) {
      return minutesControllerForDaily;
    } else if (timePeriodSelected == TimePeriodSelected.Weekly) {
      return minutesControllerForWeekly;
    } else {
      return minutesControllerForMonthly;
    }
  }

  @override
  void initState() {
    initializeControllersForDifferentPeriod();
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocConsumer<UpdateBabyBloc, UpdateBabyStates>(
      listener: (context, state) {
        print(state);
        if (state is UpdateBabyEmptyField) {
          showSnackbarError(
            AppLocalizations.of(context).emptyField,
          );
        }
        if (state is UpdateBabySuccess) {
          showSnackbarSuccess(
            AppLocalizations.of(context).updateBabySuccess,
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is UpdateBabyInProgress,
          progressIndicator: CustomCircularProgressIndicator(),
          child: Container(
              height: 265,
              width: 306,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.cancel_rounded,
                            color: purpleTheme,
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 23.0),
                    child: Text(
                      "Set STS Goal",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 29,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 23.0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Hours",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 29,
                              width: 55,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 3),
                                        blurRadius: 2,
                                        color: Colors.grey.shade200)
                                  ]),
                              child: TextField(
                                textAlign: TextAlign.center,
                                cursorColor: purpleTheme,
                                controller: hoursControllerSelected(),
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            ),
                            SizedBox(
                              width: 24,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Mins",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 29,
                                  width: 55,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 3),
                                            blurRadius: 2,
                                            color: Colors.grey.shade200)
                                      ]),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    cursorColor: purpleTheme,
                                    controller: minuteControllerSelected(),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Radio<TimePeriodSelected>(
                              activeColor: purpleTheme,
                              value: TimePeriodSelected.Daily,
                              groupValue: timePeriodSelected,
                              onChanged: (TimePeriodSelected? value) {
                                setState(() {
                                  timePeriodSelected = value;
                                });
                              },
                            ),
                            Text("Daily"),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<TimePeriodSelected>(
                              activeColor: purpleTheme,
                              value: TimePeriodSelected.Weekly,
                              groupValue: timePeriodSelected,
                              onChanged: (TimePeriodSelected? value) {
                                setState(() {
                                  timePeriodSelected = value;
                                });
                              },
                            ),
                            Text("Weekly"),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<TimePeriodSelected>(
                              activeColor: purpleTheme,
                              value: TimePeriodSelected.Monthly,
                              groupValue: timePeriodSelected,
                              onChanged: (TimePeriodSelected? value) {
                                setState(() {
                                  timePeriodSelected = value;
                                });
                                print(timePeriodSelected);
                              },
                            ),
                            Text("Monthly"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 23.0, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () async {
                            Map<String, dynamic> infantGoals = {
                              "Daily": [
                                {"hrs": hoursControllerForDaily.text},
                                {"min": minutesControllerForDaily.text}
                              ],
                              "Weekly": [
                                {"hrs": hoursControllerForWeekly.text},
                                {"min": minutesControllerForWeekly.text}
                              ],
                              "Monthly": [
                                {"hrs": hoursControllerForMonthly.text},
                                {"min": minutesControllerForMonthly.text}
                              ]
                            };

                            String jsonString = jsonEncode(infantGoals);
                            updateBabyGoalData(jsonString);
                          },
                          child: Container(
                            height: 35,
                            width: 96,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: purpleTheme),
                            child: Center(
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        );
      },
    );
  }

  updateBabyGoalData(String goalData) async {
    BlocProvider.of<UpdateBabyBloc>(context).add(
      UpdateBabyEvent(
          widget.infant.dateOfBirth,
          widget.infant.birthNotes,
          widget.infant.timeOfBirth,
          widget.infant.birthWeight,
          widget.infant.bodyLength,
          widget.infant.cribNumber,
          widget.infant.neoDeviceID, // Neo Device ID
          widget.infant.headCircumference,
          widget.infant.avatarID,
          widget.infant.resuscitation,
          widget.infant.wardNumber,
          widget.infant.presentWeight,
          widget.infant.moterName,
          widget.infant.motherUsername,
          widget.infant.neoSTS, //sts time
          widget.infant.neoNSTS, //n sts time
          widget.infant.neoTemperature, //infant temperature
          widget.infant.neoHeartRate, //infant heart rate
          widget.infant.neoRespiratoryRate, //infant respiration rate
          widget.infant.neoOxygenSaturation, //infant oxygen saturation
          widget.infant.infantId,
          widget.infant.infantTrackedInstanceID,
          goalData),
    );
  }
}


enum TimePeriodSelected { Daily, Weekly, Monthly }