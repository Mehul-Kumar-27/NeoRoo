import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoroo_app/bloc/authentication/login_bloc/login_bloc_events.dart';
import 'package:neoroo_app/bloc/authentication/login_bloc/login_bloc_states.dart';
import 'package:neoroo_app/exceptions/custom_exception.dart';
import 'package:neoroo_app/screens/authentication/local_auth_login/select_account.dart';
import 'package:neoroo_app/screens/authentication/login/components/local_auth_option.dart';
import 'package:neoroo_app/screens/authentication/login/components/login_button.dart';
import 'package:neoroo_app/screens/authentication/login/components/login_holder.dart';
import 'package:neoroo_app/screens/authentication/login/components/login_title.dart';
import 'package:neoroo_app/screens/authentication/login/components/logo.dart';
import 'package:neoroo_app/screens/authentication/login/components/password_field.dart';
import 'package:neoroo_app/screens/authentication/login/components/server_url_field.dart';
import 'package:neoroo_app/screens/authentication/login/components/sign_up.dart';
import 'package:neoroo_app/screens/authentication/login/components/username_field.dart';
import 'package:neoroo_app/screens/authentication/select_organisation/select_organisation.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:neoroo_app/utils/vertical_space.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../bloc/authentication/login_bloc/login_bloc.dart';
import 'package:local_auth/local_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _serverURLController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

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

  Future<bool> authenticate() async {
    try {
      final LocalAuthentication auth = LocalAuthentication();

      final bool didAuthenticate = await auth.authenticate(
        localizedReason: AppLocalizations.of(context).continueWithLocalAuth,
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          biometricOnly: false,
        ),
      );
      return didAuthenticate;
    } catch (e) {
      showSnackbarError(AppLocalizations.of(context).localAuthError);
      return false;
    }
  }

  void checkAuth(Map<String, List<String>> data) async {
    bool authDone = await authenticate();
    if (authDone) {
      print("Hi");
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SelectAccount(data: data),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoaded) {
            takeToSelectOrganisation(state.orgUnits);
          }
          if (state is LoginGeneralError) {
            CustomException error = state.exception;
            if (error.statusCode == null) {
              showSnackbarError(error.message);
            } else {
              showSnackbarError("${error.statusCode}: ${error.message}");
            }
          }
          if (state is LocalAuthSupportError) {
            showSnackbarError(state.message);
          }
          if (state is LocalAuthSuccess) {
            checkAuth(state.credentials);
          }
        },
        builder: (context, state) => ModalProgressHUD(
          inAsyncCall: state is LoginLoading,
          progressIndicator: CircularProgressIndicator(
            color: primaryBlue,
          ),
          child: Scaffold(
            backgroundColor: backGroundWhite,
            body: LoginHolder(
              children: [
                Container(
                  width: double.infinity,
                ),
                VerticalSpace(
                  height: MediaQuery.of(context).size.width > 600
                      ? MediaQuery.of(context).size.width * 0.01
                      : 30,
                ),
                LogoLogin(),
                TitleLogin(),
                VerticalSpace(
                  height: 35,
                ),
                ServerURLFieldLogin(
                  controller: _serverURLController,
                ),
                VerticalSpace(
                  height: 25,
                ),
                UsernameFieldLogin(
                  controller: _usernameController,
                ),
                VerticalSpace(
                  height: 25,
                ),
                PasswordFieldLogin(
                  controller: _passwordController,
                ),
                VerticalSpace(
                  height: 35,
                ),
                LoginButton(
                  onPressed: () {
                    BlocProvider.of<LoginBloc>(context).add(
                      LoginEvent(
                        _serverURLController.text,
                        _passwordController.text,
                        _usernameController.text,
                      ),
                    );
                  },
                  usernameController: _usernameController,
                  passwordController: _passwordController,
                  serverURLController: _serverURLController,
                ),
                VerticalSpace(
                  height: 35,
                ),
                LocalAuthOption(
                  onPressed: () {
                    BlocProvider.of<LoginBloc>(context).add(
                      LocalLoginEvent(),
                    );
                  },
                ),
                VerticalSpace(
                  height: 40,
                ),
                SignUpWidget(),
                VerticalSpace(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
