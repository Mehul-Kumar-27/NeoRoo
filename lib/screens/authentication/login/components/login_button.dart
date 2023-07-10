import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController serverURLController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback onPressed;
  const LoginButton({
    Key? key,
    required this.onPressed,
    required this.passwordController,
    required this.serverURLController,
    required this.usernameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        alignment: Alignment.center,
        child: Text(
          AppLocalizations.of(context).login,
          style: TextStyle(
            fontFamily: lato,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: deepWhite,
          ),
        ),
        decoration: BoxDecoration(
          color: themepurple,
          borderRadius: BorderRadius.circular(
            50,
          ),
        ),
      ),
    );
  }
}
