import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordFieldLogin extends StatefulWidget {
  final TextEditingController controller;
  const PasswordFieldLogin({Key? key, required this.controller})
      : super(key: key);

  @override
  State<PasswordFieldLogin> createState() => _PasswordFieldLoginState();
}

class _PasswordFieldLoginState extends State<PasswordFieldLogin> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextField(
        obscureText: !_isVisible,
        cursorColor: primaryBlue,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isVisible=!_isVisible;
              });
            },
            icon: Icon(
              _isVisible?Icons.visibility:Icons.visibility_off,
              color: _isVisible?primaryBlue:outlineGrey,
            ),
          ),
          contentPadding: EdgeInsets.only(
            top: 16,
            bottom: 16,
          ),
          prefixIcon: Icon(
            Icons.lock,
          ),
          hintText: AppLocalizations.of(context).password,
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
