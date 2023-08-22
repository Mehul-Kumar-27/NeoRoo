import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:neoroo_app/bloc/add_baby_bloc/add_baby_bloc.dart';
import 'package:neoroo_app/bloc/add_baby_bloc/add_baby_events.dart';
import 'package:neoroo_app/bloc/add_baby_bloc/add_baby_states.dart';
import 'package:neoroo_app/screens/add_baby/components/add_baby_avatar.dart';
import 'package:neoroo_app/screens/add_baby/components/add_baby_birth_description.dart';
import 'package:neoroo_app/screens/add_baby/components/add_baby_button.dart';
import 'package:neoroo_app/screens/add_baby/components/add_baby_input.dart';
import 'package:neoroo_app/screens/add_baby/components/add_baby_title.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:neoroo_app/utils/vertical_space.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddBaby extends StatefulWidget {
  const AddBaby({Key? key}) : super(key: key);

  @override
  State<AddBaby> createState() => _AddBabyState();
}

class _AddBabyState extends State<AddBaby> {
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

  void requestFocus(FocusNode focusNode, BuildContext current) {
    BuildContext context = Scaffold.of(current).context;
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AddBabyBloc, AddBabyStates>(
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is LoadingAddBaby,
            child: Scaffold(
              appBar: AddBabyTitle(),
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
                  AddBabyMothersName(
                    mothersName: motherName,
                    motherID: motherID,
                  ),
                  VerticalSpace(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      requestFocus(birthDateFocus, context);
                    },
                    child: AddBabyBirthDate(
                      birthDate: birthDate,
                      birthDateFocus: birthDateFocus,
                    ),
                  ),
                  VerticalSpace(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      requestFocus(birthTimeFocus, context);
                    },
                    child: AddBabyBirthTime(
                      birthTime: birthTime,
                      birthTimeFocus: birthTimeFocus,
                    ),
                  ),
                  VerticalSpace(
                    height: 15,
                  ),
                  AddBabyBirthWeight(
                    birthWeight: birthWeight,
                  ),
                  VerticalSpace(
                    height: 15,
                  ),
                  AddBabyBodyLength(
                    bodyLength: bodyLength,
                  ),
                  VerticalSpace(
                    height: 15,
                  ),
                  AddBabyHeadCircumference(
                    headCircumference: headCircumference,
                  ),
                  VerticalSpace(
                    height: 15,
                  ),
                  AddBabyNeedResuscitation(
                    needsResuscitationValue: needsResuscitation,
                  ),
                  VerticalSpace(
                    height: 15,
                  ),
                  VerticalSpace(
                    height: 15,
                  ),
                  AddBabyBirthDescription(
                    description: birthDescription,
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
                  AddBabyButton(onPressed: () {
                    String infantID =
                        "${DateTime.now().millisecondsSinceEpoch.toString()}";

                    BlocProvider.of<AddBabyBloc>(context).add(AddBabyEvent(
                      birthDate.text,
                      birthDescription.text,
                      birthTime.text,
                      birthWeight.text,
                      bodyLength.text,
                      cribNumber.text,
                      "",
                      headCircumference.text,
                      avatarDetails["value"],
                      (needsResuscitation["value"] == true) ? "Yes" : "No",
                      wardNumber.text,
                      birthWeight.text,
                      (motherName.text.isNotEmpty)
                          ? motherName.text
                          : "Unknown",
                      (motherID.text.isNotEmpty) ? motherID.text : "Unknown",
                      "", //sts time
                      "", //n sts time
                      "", //infant temperature
                      "", //infant heart rate
                      "", //infant respiration rate
                      "", //infant oxygen saturation
                      infantID,
                    ));
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        showECEBinfatSheet(context);
                      },
                      child: Text(
                        "Pull from ECEB",
                        style: TextStyle(
                          fontFamily: openSans,
                          color: secondaryOrange,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  VerticalSpace(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is AddBabyEmptyField) {
            showSnackbarError("Please Enter All the Fields");
          }
          if (state is AddBabyError) {
            showSnackbarError(state.exception.message);
          }
          if (state is AddBabySuccess) {
            showSnackbarSuccess(
              AppLocalizations.of(context).addBabySuccess,
            );
            // Navigator.of(context).pop();
          }
          if (state is EcebInfantSelectedState) {
            setState(() {
              birthDescription.text = state.infant.birthNotes;
              motherName.text = state.infant.moterName;
              motherID.text = state.infant.motherUsername;
              birthDate.text = state.infant.dateOfBirth;
              birthTime.text = state.infant.timeOfBirth;
            });
          }
        },
      ),
    );
  }
}
