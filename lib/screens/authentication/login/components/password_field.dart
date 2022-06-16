import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordFieldLogin extends StatelessWidget {
  final TextEditingController controller;
  const PasswordFieldLogin({Key? key,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextField(
        obscureText: true,
        cursorColor: primaryBlue,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: outlineGrey,
          ),
          hintText: AppLocalizations.of(context).password,
          hintStyle: TextStyle(
            color: outlineGrey,
            fontSize: 16,
            fontFamily: openSans,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryBlue,
              width: 1.75,
            ),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: outlineGrey,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
