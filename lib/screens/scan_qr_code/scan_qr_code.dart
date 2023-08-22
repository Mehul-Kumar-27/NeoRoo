import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/add_user_bloc/add_user_bloc.dart';
import 'package:neoroo_app/bloc/add_user_bloc/add_user_event.dart';
import 'package:neoroo_app/bloc/add_user_bloc/add_user_state.dart';
import 'package:neoroo_app/models/infant_model.dart';
import 'package:neoroo_app/models/qr_model.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:neoroo_app/utils/custom_loader.dart';
import 'package:neoroo_app/utils/qr_code_scanner.dart';

class ScanQrCodeScreen extends StatefulWidget {
  const ScanQrCodeScreen({super.key});

  @override
  State<ScanQrCodeScreen> createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController qrmodelController = TextEditingController();

  bool infantObtained = false;
  QrModel qrModel = QrModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: purpleTheme,
        ),
        body: BlocConsumer<AddUserBloc, AddUserState>(
          listener: (context, state) {
            if (state is InfantObtainedState) {
              setState(() {
                qrModel = state.qrModel;
                infantObtained = true;
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Infant obtained")));
            }

            if (state is AddUserFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.customException.message)));
            }
            if (state is AddUserSuccessful) {
              Infant infant = qrModel.infant!;
              setState(() {
                infant.moterName =
                    "${_firstNameController.text} ${_surnameController.text}";
                infant.motherUsername = state.uidOfUserCreated;
              });
              BlocProvider.of<AddUserBloc>(context)
                  .add(UpdateBabyWithFamilyMember(infant));
            }
            if (state is UpdateBabyForFamilyMemberSucess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("User Added and Infant Updated")));
            }
          },
          builder: (context, state) {
            if (state is AddUserEventInitial ||
                state is UpdateBabyForFamilyMemberProgress) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CustomCircularProgressIndicator(),
              );
            }
            return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    key: _formKey,
                    child: ListView(children: <Widget>[
                      TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(labelText: 'First Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _surnameController,
                        decoration: InputDecoration(labelText: 'Surname'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your surname';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          // You can add additional email validation here if needed
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          }
                          // You can add additional password validation here if needed
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      (infantObtained)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "You Are Registering As a :",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '"Family Member"',
                                        style: TextStyle(
                                            color: purpleTheme,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              BlocProvider.of<AddUserBloc>(
                                                      context)
                                                  .add(AddUserOnServer(
                                                firstName:
                                                    _firstNameController.text,
                                                lastName:
                                                    _surnameController.text,
                                                email: _emailController.text,
                                                username: _emailController.text,
                                                password:
                                                    _passwordController.text,
                                                adminPassword:
                                                    qrModel.adminPassword!,
                                                adminUsername:
                                                    qrModel.adminUsername!,
                                                serverURL: qrModel.serverURL!,
                                                organizationUnit:
                                                    qrModel.organizationUnit!,
                                              ));
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              decoration: BoxDecoration(
                                                  color: purpleTheme,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Text(
                                                  "Confirm",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    scanQrCodeDialog(context);
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                        color: purpleTheme,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Icon(
                                      Icons.qr_code,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Scan Qr Code To Register",
                            style: TextStyle(),
                          ),
                        ],
                      ),
                    ])));
          },
        ));
  }
}
