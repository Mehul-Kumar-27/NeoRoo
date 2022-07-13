import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/baby_details/baby_details_bloc.dart';
import 'package:neoroo_app/bloc/baby_details/baby_details_events.dart';
import 'package:neoroo_app/bloc/baby_details/baby_details_states.dart';
import 'package:neoroo_app/screens/baby_details/baby_details_parent/components/birth_date_time_fields.dart';
import 'package:neoroo_app/screens/baby_details/baby_details_parent/components/birth_date_time_label.dart';
import 'package:neoroo_app/screens/baby_details/baby_details_parent/components/birth_description_field.dart';
import 'package:neoroo_app/screens/baby_details/baby_details_parent/components/birth_description_label.dart';
import 'package:neoroo_app/screens/baby_details/baby_details_parent/components/birth_weight_length_fileds.dart';
import 'package:neoroo_app/screens/baby_details/baby_details_parent/components/birth_weight_length_label.dart';
import 'package:neoroo_app/screens/baby_details/baby_details_parent/components/head_circumference_field.dart';
import 'package:neoroo_app/screens/baby_details/baby_details_parent/components/head_circumference_label.dart';
import 'package:neoroo_app/screens/baby_details/baby_details_parent/components/mother_name_field.dart';
import 'package:neoroo_app/screens/baby_details/baby_details_parent/components/mothers_name_label.dart';
import 'package:neoroo_app/screens/baby_details/baby_details_parent/components/require_birth_resuscitation_field.dart';
import 'package:neoroo_app/screens/baby_details/baby_details_parent/components/require_birth_resuscitation_label.dart';
import 'package:neoroo_app/screens/baby_details/baby_details_parent/components/title_id.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:neoroo_app/utils/error_page/empty_baby_page.dart';
import 'package:neoroo_app/utils/error_page/error_page.dart';
import 'package:neoroo_app/utils/vertical_space.dart';

class BabyDetails extends StatefulWidget {
  const BabyDetails({Key? key}) : super(key: key);

  @override
  State<BabyDetails> createState() => _BabyDetailsState();
}

class _BabyDetailsState extends State<BabyDetails> {
  final TextEditingController motherName = TextEditingController();
  final TextEditingController birthDate = TextEditingController();
  final TextEditingController birthTime = TextEditingController();
  final TextEditingController birthWeight = TextEditingController();
  final TextEditingController bodyLength = TextEditingController();
  final TextEditingController headCircumference = TextEditingController();
  final TextEditingController requireBirthResuscitation =
      TextEditingController();
  final TextEditingController birthDescription = TextEditingController();
  void initialise() {
    BlocProvider.of<BabyDetailsBloc>(context).add(
      LoadBabyDetails(),
    );
  }

  @override
  void initState() {
    initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<BabyDetailsBloc, BabyDetailStates>(
          builder: (context, state) {
            if (state is BabyDetailsFetchError) {
              return ErrorPage();
            }
            if (state is BabyDetailsFamilyMemberLoaded) {
              if (state.babyDetailsFamilyMember == null) {
                return EmptyBabyPage();
              }
              if (min(MediaQuery.of(context).size.height,
                      MediaQuery.of(context).size.width) >
                  600) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.15,
                          bottom: MediaQuery.of(context).size.height * 0.10,
                        ),
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              VerticalSpace(
                                height: 25,
                              ),
                              BabyDetailsFamilyMemberTitleId(
                                id: state.babyDetailsFamilyMember!.id,
                              ),
                              VerticalSpace(
                                height: 3,
                              ),
                              MotherNameLabel(),
                              VerticalSpace(
                                height: 4,
                              ),
                              MothersNameTextField(
                                motherName: motherName
                                  ..text = state
                                      .babyDetailsFamilyMember!.motherName
                                      .toString(),
                              ),
                              VerticalSpace(
                                height: 4,
                              ),
                              BirthDateTimeLabelParent(),
                              VerticalSpace(
                                height: 4,
                              ),
                              BirthDateTimeFieldsParent(
                                birthDate: birthDate
                                  ..text = state
                                      .babyDetailsFamilyMember!.birthDate
                                      .toString(),
                                birthTime: birthTime
                                  ..text = state
                                      .babyDetailsFamilyMember!.birthTime
                                      .toString(),
                              ),
                              VerticalSpace(
                                height: 4,
                              ),
                              BirthWeightLengthLabel(),
                              VerticalSpace(
                                height: 4,
                              ),
                              BirthWeightLengthFieldsParent(
                                bodyLength: bodyLength
                                  ..text = state
                                      .babyDetailsFamilyMember!.bodyLength
                                      .toString(),
                                birthWeight: birthWeight
                                  ..text = state.babyDetailsFamilyMember!.weight
                                      .toString(),
                                weight: state.babyDetailsFamilyMember!.weight,
                                length:
                                    state.babyDetailsFamilyMember!.bodyLength,
                              ),
                              HeadCircumferenceLabel(),
                              VerticalSpace(
                                height: 5,
                              ),
                              HeadCircumferenceField(
                                headCircumference: headCircumference
                                  ..text = state.babyDetailsFamilyMember!
                                      .headCircumference
                                      .toString(),
                                headCircumferenceValue: state.babyDetailsFamilyMember!.headCircumference,
                              ),
                              RequireBirthResuscitationLabel(),
                              VerticalSpace(
                                height: 5,
                              ),
                              RequireBirthResuscitationField(
                                requireBirthResuscitation:
                                    requireBirthResuscitation
                                      ..text = state.babyDetailsFamilyMember!
                                              .needResuscitation
                                          ? "Yes"
                                          : "No",
                              ),
                              BirthDescriptionLabel(),
                              VerticalSpace(
                                height: 5,
                              ),
                              BirthDescriptionField(
                                birthDescription: birthDescription
                                  ..text =
                                      state.babyDetailsFamilyMember!.birthNotes,
                              ),
                            ],
                          ),
                        ),
                        height: 700,
                        width: 600,
                      ),
                      Container(
                        width: double.infinity,
                      ),
                    ],
                  ),
                );
              }
              return ListView(
                children: [
                  VerticalSpace(
                    height: 25,
                  ),
                  BabyDetailsFamilyMemberTitleId(
                    id: state.babyDetailsFamilyMember!.id,
                  ),
                  VerticalSpace(
                    height: 3,
                  ),
                  MotherNameLabel(),
                  VerticalSpace(
                    height: 4,
                  ),
                  MothersNameTextField(
                    motherName: motherName
                      ..text =
                          state.babyDetailsFamilyMember!.motherName.toString(),
                  ),
                  VerticalSpace(
                    height: 4,
                  ),
                  BirthDateTimeLabelParent(),
                  VerticalSpace(
                    height: 4,
                  ),
                  BirthDateTimeFieldsParent(
                    birthDate: birthDate
                      ..text =
                          state.babyDetailsFamilyMember!.birthDate.toString(),
                    birthTime: birthTime
                      ..text =
                          state.babyDetailsFamilyMember!.birthTime.toString(),
                  ),
                  VerticalSpace(
                    height: 4,
                  ),
                  BirthWeightLengthLabel(),
                  VerticalSpace(
                    height: 4,
                  ),
                  BirthWeightLengthFieldsParent(
                    bodyLength: bodyLength
                      ..text =
                          state.babyDetailsFamilyMember!.bodyLength.toString(),
                    birthWeight: birthWeight
                      ..text = state.babyDetailsFamilyMember!.weight.toString(),
                    weight: state.babyDetailsFamilyMember!.weight,
                    length: state.babyDetailsFamilyMember!.bodyLength,
                  ),
                  HeadCircumferenceLabel(),
                  VerticalSpace(
                    height: 5,
                  ),
                  HeadCircumferenceField(
                    headCircumference: headCircumference
                      ..text = state.babyDetailsFamilyMember!.headCircumference
                          .toString(),
                    headCircumferenceValue: state.babyDetailsFamilyMember!.headCircumference,
                  ),
                  RequireBirthResuscitationLabel(),
                  VerticalSpace(
                    height: 5,
                  ),
                  RequireBirthResuscitationField(
                    requireBirthResuscitation: requireBirthResuscitation
                      ..text = state.babyDetailsFamilyMember!.needResuscitation
                          ? "Yes"
                          : "No",
                  ),
                  BirthDescriptionLabel(),
                  VerticalSpace(
                    height: 5,
                  ),
                  BirthDescriptionField(
                    birthDescription: birthDescription
                      ..text = state.babyDetailsFamilyMember!.birthNotes,
                  ),
                ],
              );
            }
            if (state is BabyDetailsLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryBlue,
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
/*
return ListView(
              children: [
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 15,
                      ),
                      child: Text(
                        "Baby Birth Details",
                        style: TextStyle(
                          fontFamily: openSans,
                          color: primaryBlue,
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        right: 15,
                      ),
                      child: Text(
                        "ID: 1513",
                        style: TextStyle(
                          fontFamily: openSans,
                          color: primaryBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 15,
                    top: 15,
                  ),
                  child: Text(
                    "Mother's Name",
                    style: TextStyle(
                      fontFamily: openSans,
                      color: primaryBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primaryBlue,
                            width: 1.5,
                          ),
                        ),
                        child: TextField(
                          cursorColor: primaryBlue,
                          controller: motherName,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: openSans,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontFamily: openSans,
                              color: outlineGrey,
                              fontSize: 15,
                            ),
                            hintText: "Mother's Name",
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 15,
                          top: 15,
                        ),
                        child: Text(
                          "Birth Date",
                          style: TextStyle(
                            fontFamily: openSans,
                            color: primaryBlue,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 15,
                          top: 15,
                        ),
                        child: Text(
                          "Birth Time",
                          style: TextStyle(
                            fontFamily: openSans,
                            color: primaryBlue,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primaryBlue,
                            width: 1.5,
                          ),
                        ),
                        child: TextField(
                          cursorColor: primaryBlue,
                          textAlignVertical: TextAlignVertical.center,
                          controller: birthDate,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: openSans,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontFamily: openSans,
                              color: outlineGrey,
                              fontSize: 15,
                            ),
                            hintText: "Birth Date",
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.015,
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primaryBlue,
                            width: 1.5,
                          ),
                        ),
                        child: TextField(
                          cursorColor: primaryBlue,
                          textAlignVertical: TextAlignVertical.center,
                          controller: birthTime,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: openSans,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontFamily: openSans,
                              color: outlineGrey,
                              fontSize: 15,
                            ),
                            hintText: "Birth Time",
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 15,
                          top: 15,
                        ),
                        child: Text(
                          "Birth Weight",
                          style: TextStyle(
                            fontFamily: openSans,
                            color: primaryBlue,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 15,
                          top: 15,
                        ),
                        child: Text(
                          "Body Length",
                          style: TextStyle(
                            fontFamily: openSans,
                            color: primaryBlue,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primaryBlue,
                            width: 1.5,
                          ),
                        ),
                        child: TextField(
                          cursorColor: primaryBlue,
                          controller: birthWeight,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: openSans,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontFamily: openSans,
                              color: outlineGrey,
                              fontSize: 15,
                            ),
                            hintText: "Birth Weight",
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.015,
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primaryBlue,
                            width: 1.5,
                          ),
                        ),
                        child: TextField(
                          cursorColor: primaryBlue,
                          textAlignVertical: TextAlignVertical.center,
                          controller: bodyLength,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: openSans,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontFamily: openSans,
                              color: outlineGrey,
                              fontSize: 15,
                            ),
                            hintText: "Body Length",
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 15,
                    top: 15,
                  ),
                  child: Text(
                    "Head Circumference",
                    style: TextStyle(
                      fontFamily: openSans,
                      color: primaryBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primaryBlue,
                            width: 1.5,
                          ),
                        ),
                        child: TextField(
                          cursorColor: primaryBlue,
                          textAlignVertical: TextAlignVertical.center,
                          controller: headCircumference,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: openSans,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontFamily: openSans,
                              color: outlineGrey,
                              fontSize: 15,
                            ),
                            hintText: "Head Circumference",
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 15,
                    top: 15,
                  ),
                  child: Text(
                    "Require Birth Resuscitation",
                    style: TextStyle(
                      fontFamily: openSans,
                      color: primaryBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primaryBlue,
                            width: 1.5,
                          ),
                        ),
                        child: TextField(
                          cursorColor: primaryBlue,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: openSans,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontFamily: openSans,
                              color: outlineGrey,
                              fontSize: 15,
                            ),
                            suffixIcon: Icon(
                              CupertinoIcons.chevron_down,
                              color: primaryBlue,
                            ),
                            hintText: "Require Birth Resuscitation",
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 15,
                    top: 15,
                  ),
                  child: Text(
                    "Birth Description",
                    style: TextStyle(
                      fontFamily: openSans,
                      color: primaryBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primaryBlue,
                            width: 1.5,
                          ),
                        ),
                        child: TextField(
                          cursorColor: primaryBlue,
                          controller: birthDescription,
                          textAlignVertical: TextAlignVertical.center,
                          minLines: 3,
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: openSans,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontFamily: openSans,
                              color: outlineGrey,
                              fontSize: 15,
                            ),
                            hintText: "Birth Description",
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
 */
