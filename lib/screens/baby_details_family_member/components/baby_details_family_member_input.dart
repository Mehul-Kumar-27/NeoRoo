import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neoroo_app/utils/vertical_space.dart';

class BabyDetailsFamilyMemberMothersName extends StatelessWidget {
  final String mothersName;
  const BabyDetailsFamilyMemberMothersName(
      {Key? key, required this.mothersName})
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
            enabled: false,
            controller: TextEditingController()..text = mothersName,
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

class BabyDetailsFamilyMemberBirthDate extends StatelessWidget {
  final String birthDate;
  const BabyDetailsFamilyMemberBirthDate({Key? key, required this.birthDate})
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
          TextField(
            cursorColor: primaryBlue,
            enabled: false,
            controller: TextEditingController()..text = birthDate,
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
        ],
      ),
    );
  }
}

class BabyDetailsFamilyMemberBirthTime extends StatelessWidget {
  final String birthTime;
  const BabyDetailsFamilyMemberBirthTime({Key? key, required this.birthTime})
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
          TextField(
            cursorColor: primaryBlue,
            enabled: false,
            controller: TextEditingController()..text = birthTime,
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
        ],
      ),
    );
  }
}

class BabyDetailsFamilyMemberBirthWeight extends StatefulWidget {
  final double weight;
  const BabyDetailsFamilyMemberBirthWeight({Key? key, required this.weight})
      : super(key: key);

  @override
  State<BabyDetailsFamilyMemberBirthWeight> createState() =>
      _BabyDetailsFamilyMemberBirthWeightState();
}

class _BabyDetailsFamilyMemberBirthWeightState
    extends State<BabyDetailsFamilyMemberBirthWeight> {
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
                      enabled: false,
                      controller: TextEditingController()
                        ..text = _selectedUnit == "g"
                            ? widget.weight.toString()
                            : (widget.weight / 453.6).toStringAsFixed(
                                1,
                              ),
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

class BabyDetailsFamilyMemberBodyLength extends StatefulWidget {
  final double bodyLength;
  const BabyDetailsFamilyMemberBodyLength({
    Key? key,
    required this.bodyLength,
  }) : super(key: key);

  @override
  State<BabyDetailsFamilyMemberBodyLength> createState() =>
      _BabyDetailsFamilyMemberBodyLengthState();
}

class _BabyDetailsFamilyMemberBodyLengthState
    extends State<BabyDetailsFamilyMemberBodyLength> {
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
                      enabled: false,
                      cursorColor: primaryBlue,
                      controller: TextEditingController()
                        ..text = (_selectedUnit == "cm"
                            ? widget.bodyLength.toString()
                            : (widget.bodyLength / 2.54).toStringAsFixed(1)),
                      textAlignVertical: TextAlignVertical.center,
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

class BabyDetailsFamilyMemberHeadCircumference extends StatefulWidget {
  final double headCircumference;
  const BabyDetailsFamilyMemberHeadCircumference(
      {Key? key, required this.headCircumference})
      : super(key: key);

  @override
  State<BabyDetailsFamilyMemberHeadCircumference> createState() =>
      _BabyDetailsFamilyMemberHeadCircumferenceState();
}

class _BabyDetailsFamilyMemberHeadCircumferenceState
    extends State<BabyDetailsFamilyMemberHeadCircumference> {
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
                      enabled: false,
                      controller: TextEditingController()
                        ..text = (_selectedUnit == "cm"
                            ? widget.headCircumference.toString()
                            : (widget.headCircumference / 2.54)
                                .toStringAsFixed(1)),
                      cursorColor: primaryBlue,
                      textAlignVertical: TextAlignVertical.center,
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

class BabyDetailsFamilyMemberNeedResuscitation extends StatefulWidget {
  final bool needsResuscitation;
  const BabyDetailsFamilyMemberNeedResuscitation(
      {Key? key, required this.needsResuscitation})
      : super(key: key);

  @override
  State<BabyDetailsFamilyMemberNeedResuscitation> createState() =>
      _BabyDetailsFamilyMemberNeedResuscitationState();
}

class _BabyDetailsFamilyMemberNeedResuscitationState
    extends State<BabyDetailsFamilyMemberNeedResuscitation> {
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
            onChanged: null,
            value: widget.needsResuscitation ? "yes" : "no",
          ),
        ],
      ),
    );
  }
}

class BabyDetailsFamilyMemberParentGroup extends StatefulWidget {
  final String parentGroup;
  const BabyDetailsFamilyMemberParentGroup(
      {Key? key, required this.parentGroup})
      : super(key: key);

  @override
  State<BabyDetailsFamilyMemberParentGroup> createState() =>
      _BabyDetailsFamilyMemberParentGroupState();
}

class _BabyDetailsFamilyMemberParentGroupState
    extends State<BabyDetailsFamilyMemberParentGroup> {
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
            enabled: false,
            controller: TextEditingController()..text = widget.parentGroup,
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

class BabyDetailsFamilyMemberCaregiverGroup extends StatefulWidget {
  final String caregiverGroup;
  const BabyDetailsFamilyMemberCaregiverGroup(
      {Key? key, required this.caregiverGroup})
      : super(key: key);

  @override
  State<BabyDetailsFamilyMemberCaregiverGroup> createState() =>
      _BabyDetailsFamilyMemberCaregiverGroupState();
}

class _BabyDetailsFamilyMemberCaregiverGroupState
    extends State<BabyDetailsFamilyMemberCaregiverGroup> {
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
            enabled: false,
            controller: TextEditingController()..text = widget.caregiverGroup,
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
