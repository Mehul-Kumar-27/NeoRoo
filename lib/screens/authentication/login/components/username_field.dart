import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UsernameFieldLogin extends StatelessWidget {
  final TextEditingController controller;
  const UsernameFieldLogin({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextField(
        cursorColor: primaryBlue,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: 16,
            bottom: 16,
          ),
          prefixIcon: Icon(
            Icons.person,
          ),
          hintText: AppLocalizations.of(context).username,
          prefixIconColor: primaryBlue,
          hintStyle: TextStyle(
            color: outlineGrey,
            fontSize: 16,
            fontFamily: openSans,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: primaryBlue,
              width: 1.75,
            ),
          ),
          border: OutlineInputBorder(
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
