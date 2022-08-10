import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neoroo_app/utils/vertical_space.dart';

class AddBabyMothersName extends StatelessWidget {
  final TextEditingController mothersName;
  const AddBabyMothersName({Key? key, required this.mothersName,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).motherName,
            style: TextStyle(
              fontFamily: openSans,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          VerticalSpace(
            height: 5,
          ),
          TextField(
            cursorColor: primaryBlue,
            controller: mothersName,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              hintText: AppLocalizations.of(context).motherName,
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: outlineGrey,
                ),
              ),
              prefixIcon: Icon(
                Icons.pregnant_woman,
                color: outlineGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddBabyBirthDate extends StatefulWidget {
  final TextEditingController birthDate;
  final FocusNode birthDateFocus;
  const AddBabyBirthDate({
    Key? key,
    required this.birthDate,
    required this.birthDateFocus,
  }) : super(key: key);

  @override
  State<AddBabyBirthDate> createState() => _AddBabyBirthDateState();
}

class _AddBabyBirthDateState extends State<AddBabyBirthDate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).birthDate,
            style: TextStyle(
              fontFamily: openSans,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          VerticalSpace(
            height: 5,
          ),
          GestureDetector(
            onTap: () async {
              DateTime? selectedDate=await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(
                  Duration(
                    days: 30*9,
                  ),
                ),
                lastDate: DateTime.now().add(
                  Duration(
                    hours: 24,
                  ),
                ),
              );
              if(selectedDate==null){
                setState(() {
                  widget.birthDate.clear();
                });
              }else{
                setState(() {
                  widget.birthDate.text="${selectedDate.day<10?"0":""}${selectedDate.day}-${selectedDate.month<10?"0":""}${selectedDate.month}-${selectedDate.year}";
                });
              }
            },
            child: TextField(
              cursorColor: primaryBlue,
              controller: widget.birthDate,
              focusNode: widget.birthDateFocus,
              enabled: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                hintText: AppLocalizations.of(context).birthDate,
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: outlineGrey,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.date_range,
                  color: outlineGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddBabyBirthTime extends StatefulWidget {
  final TextEditingController birthTime;
  final FocusNode birthTimeFocus;
  const AddBabyBirthTime({
    Key? key,
    required this.birthTime,
    required this.birthTimeFocus,
  }) : super(key: key);

  @override
  State<AddBabyBirthTime> createState() => _AddBabyBirthTimeState();
}

class _AddBabyBirthTimeState extends State<AddBabyBirthTime> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).birthTime,
            style: TextStyle(
              fontFamily: openSans,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          VerticalSpace(
            height: 5,
          ),
          GestureDetector(
            onTap: () async {
              TimeOfDay? selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                useRootNavigator: false,
                initialEntryMode: TimePickerEntryMode.input,
              );
              if (selectedTime == null) {
                setState(() {
                  widget.birthTime.clear();
                });
              } else {
                setState(() {
                  widget.birthTime.text =
                      "${selectedTime.hour < 10 ? "0" : ""}${selectedTime.hour}:${selectedTime.minute < 10 ? "0" : ""}${selectedTime.minute}";
                });
              }
            },
            child: TextField(
              cursorColor: primaryBlue,
              controller: widget.birthTime,
              focusNode: widget.birthTimeFocus,
              enabled: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                hintText: AppLocalizations.of(context).birthTime,
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: outlineGrey,
                  ),
                ),
                prefixIcon: Icon(
                  CupertinoIcons.time,
                  color: outlineGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddBabyBirthWeight extends StatefulWidget {
  final TextEditingController birthWeight;
  const AddBabyBirthWeight({Key? key, required this.birthWeight})
      : super(key: key);

  @override
  State<AddBabyBirthWeight> createState() => _AddBabyBirthWeightState();
}

class _AddBabyBirthWeightState extends State<AddBabyBirthWeight> {
  String _selectedUnit = "g";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).birthWeight,
            style: TextStyle(
              fontFamily: openSans,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          VerticalSpace(
            height: 5,
          ),
          Table(
            columnWidths: {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      right: 20,
                    ),
                    child: TextField(
                      cursorColor: primaryBlue,
                      controller: widget.birthWeight,
                      keyboardType: TextInputType.number,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        hintText: AppLocalizations.of(context).birthWeight,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: outlineGrey,
                          ),
                        ),
                        prefixIcon: Icon(
                          FontAwesomeIcons.scaleBalanced,
                          color: outlineGrey,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: DropdownButtonFormField(
                        items: <DropdownMenuItem<String>>[
                          DropdownMenuItem(
                            child: Text(
                              "g",
                              style: TextStyle(
                                fontFamily: openSans,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            value: "g",
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "lbs",
                              style: TextStyle(
                                fontFamily: openSans,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            value: "lbs",
                          ),
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            _selectedUnit = value!;
                          });
                          if (widget.birthWeight.text.isNotEmpty) {
                            setState(
                              () {
                                if (_selectedUnit == "lbs") {
                                  widget.birthWeight.text =
                                      (double.parse(widget.birthWeight.text) /
                                              453.6)
                                          .toStringAsFixed(1);
                                } else {
                                  widget.birthWeight.text =
                                      (double.parse(widget.birthWeight.text)*453.6)
                                          .toStringAsFixed(1);
                                }
                              },
                            );
                          }
                        },
                        value: _selectedUnit,
                      ),
                    ),
                    verticalAlignment: TableCellVerticalAlignment.fill,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddBabyBodyLength extends StatefulWidget {
  final TextEditingController bodyLength;
  const AddBabyBodyLength({
    Key? key,
    required this.bodyLength,
  }) : super(key: key);

  @override
  State<AddBabyBodyLength> createState() => _AddBabyBodyLengthState();
}

class _AddBabyBodyLengthState extends State<AddBabyBodyLength> {
  String _selectedUnit = "cm";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).bodyLength,
            style: TextStyle(
              fontFamily: openSans,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          VerticalSpace(
            height: 5,
          ),
          Table(
            columnWidths: {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      right: 20,
                    ),
                    child: TextField(
                      cursorColor: primaryBlue,
                      controller: widget.bodyLength,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        hintText: AppLocalizations.of(context).bodyLength,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: outlineGrey,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.linear_scale,
                          color: outlineGrey,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: DropdownButtonFormField<String>(
                        style: TextStyle(
                          fontFamily: openSans,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: outlineGrey,
                            ),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: outlineGrey,
                            ),
                          ),
                        ),
                        items: <DropdownMenuItem<String>>[
                          DropdownMenuItem(
                            child: Text(
                              "cm",
                              style: TextStyle(
                                fontFamily: openSans,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            value: "cm",
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "inch",
                              style: TextStyle(
                                fontFamily: openSans,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            value: "inch",
                          ),
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            _selectedUnit = value!;
                          });
                          if (widget.bodyLength.text.isNotEmpty) {
                            setState(
                              () {
                                if (_selectedUnit == "inch") {
                                  widget.bodyLength.text =
                                      (double.parse(widget.bodyLength.text) /
                                              2.54)
                                          .toStringAsFixed(1);
                                } else {
                                  widget.bodyLength.text =
                                      (double.parse(widget.bodyLength.text) *
                                              2.54)
                                          .toStringAsFixed(1);
                                }
                              },
                            );
                          }
                        },
                        value: _selectedUnit,
                      ),
                    ),
                    verticalAlignment: TableCellVerticalAlignment.fill,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddBabyHeadCircumference extends StatefulWidget {
  final TextEditingController headCircumference;
  const AddBabyHeadCircumference({Key? key, required this.headCircumference})
      : super(key: key);

  @override
  State<AddBabyHeadCircumference> createState() =>
      _AddBabyHeadCircumferenceState();
}

class _AddBabyHeadCircumferenceState extends State<AddBabyHeadCircumference> {
  String _selectedUnit = "cm";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).headCircumference,
            style: TextStyle(
              fontFamily: openSans,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          VerticalSpace(
            height: 5,
          ),
          Table(
            columnWidths: {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      right: 20,
                    ),
                    child: TextField(
                      controller: widget.headCircumference,
                      cursorColor: primaryBlue,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        hintText:
                            AppLocalizations.of(context).headCircumference,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: outlineGrey,
                          ),
                        ),
                        prefixIcon: Icon(
                          FontAwesomeIcons.baby,
                          color: outlineGrey,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      child: DropdownButtonFormField<String>(
                        style: TextStyle(
                          fontFamily: openSans,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: outlineGrey,
                            ),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: outlineGrey,
                            ),
                          ),
                        ),
                        items: <DropdownMenuItem<String>>[
                          DropdownMenuItem(
                            child: Text(
                              "cm",
                              style: TextStyle(
                                fontFamily: openSans,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            value: "cm",
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "inch",
                              style: TextStyle(
                                fontFamily: openSans,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            value: "inch",
                          ),
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            _selectedUnit = value!;
                          });
                          if (widget.headCircumference.text.isNotEmpty) {
                            setState(
                              () {
                                if (_selectedUnit == "inch") {
                                  widget.headCircumference.text = (double.parse(
                                              widget.headCircumference.text) /
                                          2.54)
                                      .toStringAsFixed(1);
                                } else {
                                  widget.headCircumference.text = (double.parse(
                                              widget.headCircumference.text) *
                                          2.54)
                                      .toStringAsFixed(1);
                                }
                              },
                            );
                          }
                        },
                        value: _selectedUnit,
                      ),
                    ),
                    verticalAlignment: TableCellVerticalAlignment.fill,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddBabyNeedResuscitation extends StatefulWidget {
  final Map<String, bool> needsResuscitationValue;
  const AddBabyNeedResuscitation(
      {Key? key, required this.needsResuscitationValue})
      : super(key: key);

  @override
  State<AddBabyNeedResuscitation> createState() =>
      _AddBabyNeedResuscitationState();
}

class _AddBabyNeedResuscitationState extends State<AddBabyNeedResuscitation> {
  String selectedValue = "no";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).requireBirthResuscitation,
            style: TextStyle(
              fontFamily: openSans,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          VerticalSpace(
            height: 5,
          ),
          DropdownButtonFormField<String>(
            style: TextStyle(
              fontFamily: openSans,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: outlineGrey,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: outlineGrey,
                ),
              ),
            ),
            items: <DropdownMenuItem<String>>[
              DropdownMenuItem(
                child: Text(
                  "No",
                  style: TextStyle(
                    fontFamily: openSans,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                value: "no",
              ),
              DropdownMenuItem(
                child: Text(
                  "Yes",
                  style: TextStyle(
                    fontFamily: openSans,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                value: "yes",
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
                widget.needsResuscitationValue["value"] =
                    (value == "yes" ? true : false);
              });
            },
            value: selectedValue,
          ),
        ],
      ),
    );
  }
}

class AddBabyParentGroup extends StatefulWidget {
  final TextEditingController parentGroup;
  const AddBabyParentGroup({Key? key, required this.parentGroup})
      : super(key: key);

  @override
  State<AddBabyParentGroup> createState() => _AddBabyParentGroupState();
}

class _AddBabyParentGroupState extends State<AddBabyParentGroup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).familyMemberGroup,
            style: TextStyle(
              fontFamily: openSans,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          VerticalSpace(
            height: 5,
          ),
          TextField(
            cursorColor: primaryBlue,
            controller: widget.parentGroup,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              hintText: AppLocalizations.of(context).familyMemberGroup,
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: outlineGrey,
                ),
              ),
              prefixIcon: Icon(
                Icons.family_restroom,
                color: outlineGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddBabyCaregiverGroup extends StatefulWidget {
  final TextEditingController caregiverGroup;
  const AddBabyCaregiverGroup({Key? key, required this.caregiverGroup})
      : super(key: key);

  @override
  State<AddBabyCaregiverGroup> createState() => _AddBabyCaregiverGroupState();
}

class _AddBabyCaregiverGroupState extends State<AddBabyCaregiverGroup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).caregiverGroup,
            style: TextStyle(
              fontFamily: openSans,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          VerticalSpace(
            height: 5,
          ),
          TextField(
            cursorColor: primaryBlue,
            controller: widget.caregiverGroup,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              hintText: AppLocalizations.of(context).caregiverGroup,
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: outlineGrey,
                ),
              ),
              prefixIcon: Icon(
                Icons.family_restroom,
                color: outlineGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
