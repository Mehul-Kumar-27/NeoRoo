import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:neoroo_app/bloc/update_baby_bloc/update_baby_bloc.dart';
import 'package:neoroo_app/bloc/update_baby_bloc/update_baby_events.dart';
import 'package:neoroo_app/bloc/update_baby_bloc/update_baby_states.dart';
import 'package:neoroo_app/models/baby_details_caregiver.dart';
import 'package:neoroo_app/models/infant_model.dart';
import 'package:neoroo_app/screens/add_baby/components/add_baby_input.dart';
import 'package:neoroo_app/screens/bluethooth_screen/bluethooth_scan.dart';
import 'package:neoroo_app/screens/update_baby/components/update_baby_avatar.dart';
import 'package:neoroo_app/screens/update_baby/components/update_baby_birth_description.dart';
import 'package:neoroo_app/screens/update_baby/components/update_baby_button.dart';
import 'package:neoroo_app/screens/update_baby/components/update_baby_input.dart';
import 'package:neoroo_app/screens/update_baby/components/update_baby_title.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:neoroo_app/utils/vertical_space.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateBaby extends StatefulWidget {
  final Infant infant;
  final int index;
  const UpdateBaby({Key? key, required this.infant, required this.index})
      : super(key: key);

  @override
  State<UpdateBaby> createState() => _UpdateBabyState();
}

class _UpdateBabyState extends State<UpdateBaby> {
  final TextEditingController motherName = TextEditingController();
  final TextEditingController birthDate = TextEditingController();
  final TextEditingController birthTime = TextEditingController();
  final TextEditingController birthWeight = TextEditingController();
  final TextEditingController bodyLength = TextEditingController();
  final TextEditingController headCircumference = TextEditingController();
  final TextEditingController cribNumber = TextEditingController();
  final TextEditingController wardNumber = TextEditingController();
  final TextEditingController birthDescription = TextEditingController();
  final TextEditingController motherID = TextEditingController();
  final Map<String, XFile?> avatarDetails = {};
  final FocusNode birthDateFocus = FocusNode();
  final FocusNode birthTimeFocus = FocusNode();
  final ImagePicker _imagePicker = ImagePicker();
  final Map<String, bool> needsResuscitation = {
    "value": false,
  };
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

  @override
  void initState() {
    motherName.text = widget.infant.moterName;
    motherID.text = widget.infant.motherUsername;
    birthDate.text = widget.infant.dateOfBirth;
    birthTime.text = widget.infant.timeOfBirth;
    birthWeight.text = widget.infant.birthWeight;
    bodyLength.text = widget.infant.bodyLength.toString();
    headCircumference.text = widget.infant.headCircumference.toString();
    birthDescription.text = widget.infant.birthNotes;
    cribNumber.text = widget.infant.cribNumber;
    wardNumber.text = widget.infant.wardNumber;

    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<UpdateBabyBloc, UpdateBabyStates>(
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
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) => ModalProgressHUD(
          inAsyncCall: state is UpdateBabyInProgress,
          progressIndicator: CircularProgressIndicator(
            color: primaryBlue,
          ),
          child: Scaffold(
            appBar: UpdateBabyTitle(),
            body: ListView(
              children: [
                VerticalSpace(
                  height: 30,
                ),
                BabyDetailsAvatar(
                  imageData: avatarDetails,
                  imagePicker: _imagePicker,
                ),
                VerticalSpace(
                  height: 20,
                ),
                UpdateBabyMothersName(
                  mothersName: motherName,
                ),
                VerticalSpace(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {},
                  child: UpdateBabyBirthDate(
                    birthDate: birthDate,
                    birthDateFocus: birthDateFocus,
                  ),
                ),
                VerticalSpace(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {},
                  child: UpdateBabyBirthTime(
                    birthTime: birthTime,
                    birthTimeFocus: birthTimeFocus,
                  ),
                ),
                VerticalSpace(
                  height: 15,
                ),
                UpdateBabyBirthWeight(
                  birthWeight: birthWeight,
                ),
                VerticalSpace(
                  height: 15,
                ),
                UpdateBabyBodyLength(
                  bodyLength: bodyLength
                    ..text = widget.infant.bodyLength.toString(),
                ),
                VerticalSpace(
                  height: 15,
                ),
                UpdateBabyHeadCircumference(
                  headCircumference: headCircumference,
                ),
                VerticalSpace(
                  height: 15,
                ),
                UpdateBabyNeedResuscitation(
                  needsResuscitationValue: needsResuscitation
                    ..["value"] =
                        (widget.infant.resuscitation == "Yes") ? true : false,
                ),
                VerticalSpace(
                  height: 15,
                ),
                UpdateBabyBirthDescription(
                  description: birthDescription
                    ..text = widget.infant.birthNotes,
                ),
                VerticalSpace(
                  height: 15,
                ),
                BabyWardCribNumber(
                    controller: wardNumber, heading: "Baby Ward Number"),
                VerticalSpace(
                  height: 15,
                ),
                BabyWardCribNumber(
                    controller: cribNumber, heading: "Baby Crib Number"),
                VerticalSpace(
                  height: 30,
                ),
                VerticalSpace(
                  height: 30,
                ),
                UpdateBabyButton(
                  onPressed: () {
                    BlocProvider.of<UpdateBabyBloc>(context).add(
                      UpdateBabyEvent(
                        birthDate.text,
                        birthDescription.text,
                        birthTime.text,
                        birthWeight.text,
                        bodyLength.text,
                        cribNumber.text,
                        widget.infant.neoDeviceID, // Neo Device ID
                        headCircumference.text,
                        widget.infant.avatarID,
                        (needsResuscitation["value"] == true) ? "Yes" : "No",
                        wardNumber.text,
                        birthWeight.text,
                        motherName.text,
                        motherID.text,
                        widget.infant.neoSTS, //sts time
                        widget.infant.neoNSTS, //n sts time
                        widget.infant.neoTemperature, //infant temperature
                        widget.infant.neoHeartRate, //infant heart rate
                        widget.infant
                            .neoRespiratoryRate, //infant respiration rate
                        widget.infant
                            .neoOxygenSaturation, //infant oxygen saturation
                        widget.infant.infantId,
                        widget.infant.infantTrackedInstanceID,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BluethoothScan()));
                        },
                        child: Container(
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 3), color: Colors.purple)
                              ]),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.bluetooth,
                                  color: Colors.blueAccent,
                                ),
                                Text("Scan")
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Scan QR Code",
                          style: TextStyle(
                            fontFamily: openSans,
                            color: secondaryOrange,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalSpace(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
