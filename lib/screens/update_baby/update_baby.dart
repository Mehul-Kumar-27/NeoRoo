import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:neoroo_app/bloc/update_baby_bloc/update_baby_bloc.dart';
import 'package:neoroo_app/bloc/update_baby_bloc/update_baby_events.dart';
import 'package:neoroo_app/bloc/update_baby_bloc/update_baby_states.dart';
import 'package:neoroo_app/models/baby_details_caregiver.dart';
import 'package:neoroo_app/screens/update_baby/components/update_baby_avatar.dart';
import 'package:neoroo_app/screens/update_baby/components/update_baby_birth_description.dart';
import 'package:neoroo_app/screens/update_baby/components/update_baby_button.dart';
import 'package:neoroo_app/screens/update_baby/components/update_baby_input.dart';
import 'package:neoroo_app/screens/update_baby/components/update_baby_title.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:neoroo_app/utils/vertical_space.dart';
import './components/update_baby_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateBaby extends StatefulWidget {
  final BabyDetailsCaregiver babyDetailsCaregiver;
  final int index;
  const UpdateBaby(
      {Key? key, required this.babyDetailsCaregiver, required this.index})
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
  final TextEditingController parentGroup = TextEditingController();
  final TextEditingController caregiverGroup = TextEditingController();
  final TextEditingController birthDescription = TextEditingController();
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<UpdateBabyBloc, UpdateBabyStates>(
        listener: (context, state) {
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
                  mothersName: motherName
                    ..text = widget.babyDetailsCaregiver.motherName,
                ),
                VerticalSpace(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {},
                  child: UpdateBabyBirthDate(
                    birthDate: birthDate
                      ..text = widget.babyDetailsCaregiver.birthDate,
                    birthDateFocus: birthDateFocus,
                  ),
                ),
                VerticalSpace(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {},
                  child: UpdateBabyBirthTime(
                    birthTime: birthTime
                      ..text = widget.babyDetailsCaregiver.birthTime,
                    birthTimeFocus: birthTimeFocus,
                  ),
                ),
                VerticalSpace(
                  height: 15,
                ),
                UpdateBabyBirthWeight(
                  birthWeight: birthWeight
                    ..text = widget.babyDetailsCaregiver.weight.toString(),
                ),
                VerticalSpace(
                  height: 15,
                ),
                UpdateBabyBodyLength(
                  bodyLength: bodyLength
                    ..text = widget.babyDetailsCaregiver.bodyLength.toString(),
                ),
                VerticalSpace(
                  height: 15,
                ),
                UpdateBabyHeadCircumference(
                  headCircumference: headCircumference
                    ..text = widget.babyDetailsCaregiver.headCircumference
                        .toString(),
                ),
                VerticalSpace(
                  height: 15,
                ),
                UpdateBabyNeedResuscitation(
                  needsResuscitationValue: needsResuscitation
                    ..["value"] = widget.babyDetailsCaregiver.needResuscitation,
                ),
                VerticalSpace(
                  height: 15,
                ),
                UpdateBabyParentGroup(
                  parentGroup: parentGroup
                    ..text = widget.babyDetailsCaregiver.familyMemberGroup,
                ),
                VerticalSpace(
                  height: 15,
                ),
                UpdateBabyCaregiverGroup(
                  caregiverGroup: caregiverGroup
                    ..text = widget.babyDetailsCaregiver.caregiverGroup,
                ),
                VerticalSpace(
                  height: 15,
                ),
                UpdateBabyBirthDescription(
                  description: birthDescription
                    ..text = widget.babyDetailsCaregiver.birthNotes,
                ),
                VerticalSpace(
                  height: 30,
                ),
                UpdateBabyButton(
                  onPressed: () {
                    BlocProvider.of<UpdateBabyBloc>(context).add(
                      UpdateBabyEvent(
                        motherName: motherName.text,
                        birthDate: birthDate.text,
                        index: widget.index,
                        birthTime: birthTime.text,
                        birthWeight: birthWeight.text,
                        headCircumference: headCircumference.text,
                        bodyLength: bodyLength.text,
                        birthDescription: birthDescription.text,
                        caregiverGroup: caregiverGroup.text,
                        familyMemberGroup: parentGroup.text,
                        needResuscitation: needsResuscitation["value"]! ? 1 : 0,
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
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Pull from ECEB",
                          style: TextStyle(
                            fontFamily: openSans,
                            color: secondaryOrange,
                            fontSize: 16,
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
