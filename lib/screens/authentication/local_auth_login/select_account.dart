import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:neoroo_app/bloc/authentication/local_auth_login_bloc/local_authentication_bloc.dart';
import 'package:neoroo_app/bloc/authentication/local_auth_login_bloc/local_authentication_events.dart';
import 'package:neoroo_app/bloc/authentication/local_auth_login_bloc/local_authentication_states.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/screens/authentication/local_auth_login/components/select_account_list_item.dart';
import 'package:neoroo_app/screens/authentication/local_auth_login/components/select_account_title.dart';
import 'package:neoroo_app/screens/authentication/select_organisation/select_organisation.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:neoroo_app/utils/vertical_space.dart';

class SelectAccount extends StatefulWidget {
  final Map<String, List<String>> data;
  const SelectAccount({Key? key, required this.data}) : super(key: key);

  @override
  State<SelectAccount> createState() => _SelectAccountState();
}

class _SelectAccountState extends State<SelectAccount> {
  void takeToSelectOrganisation(List<String> orgUnits) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SelectOrganisation(),
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    final keys = widget.data.keys.toList();
    return SafeArea(
      child: BlocConsumer<LocalAuthBloc, LocalAuthStates>(
        listener: (context, state) {
          if (state is LocalAuthLoaded) {
            takeToSelectOrganisation(state.orgUnits);
          }
          if (state is LocalAuthGeneralError) {
            CustomException error = state.exception;
            if (error.statusCode == null) {
              showSnackbarError(error.message);
            } else {
              showSnackbarError("${error.statusCode}: ${error.message}");
            }
          }
        },
        builder: (context, state) => ModalProgressHUD(
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpace(
                  height: 20,
                ),
                SelectAccountTitle(),
                VerticalSpace(
                  height: 20,
                ),
                VerticalSpace(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                ),
                VerticalSpace(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => SelectAccountListItem(
                      image: widget.data[keys[index]]!.length == 3
                          ? null
                          : widget.data[keys[index]]!.last,
                      serverURL: widget.data[keys[index]]![1],
                      username: keys[index],
                      name: widget.data[keys[index]]![2],
                      password: widget.data[keys[index]]![0],
                      login: () {
                        BlocProvider.of<LocalAuthBloc>(context).add(
                          LocalAuthRequestEvent(
                            widget.data[keys[index]]![1],
                            widget.data[keys[index]]![0],
                            keys[index],
                          ),
                        );
                      },
                    ),
                    itemCount: keys.length,
                  ),
                ),
              ],
            ),
          ),
          inAsyncCall: state is LocalAuthLoading,
          progressIndicator: CircularProgressIndicator(
            color: primaryBlue,
          ),
        ),
      ),
    );
  }
}
