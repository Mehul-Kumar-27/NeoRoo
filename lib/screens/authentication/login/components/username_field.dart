import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UsernameFieldLogin extends StatelessWidget {
  final TextEditingController controller;
  const UsernameFieldLogin({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 3,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: deepWhite, borderRadius: BorderRadius.circular(20)),
        child: TextField(
          controller: controller,
          cursorColor: primaryBlue,
          decoration: InputDecoration(
            fillColor: deepWhite,
            contentPadding: EdgeInsets.only(
              top: 16,
              bottom: 16,
            ),
            prefixIcon: Icon(
              Icons.person,
              color: themepurple,
            ),
            hintText: AppLocalizations.of(context).username,
            hintStyle: TextStyle(
              color: textGrey,
              fontFamily: openSans,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ),
    );
  }
}
