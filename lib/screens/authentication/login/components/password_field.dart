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
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 3,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: deepWhite, borderRadius: BorderRadius.circular(20)),
        child: TextField(
          obscureText: !_isVisible,
          cursorColor: primaryBlue,
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              icon: Icon(
                _isVisible ? Icons.visibility : Icons.visibility_off,
                color: _isVisible ? themepurple : outlineGrey,
              ),
            ),
            contentPadding: EdgeInsets.only(
              top: 16,
              bottom: 16,
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: themepurple,
            ),
            hintText: AppLocalizations.of(context).password,
            prefixIconColor: primaryBlue,
            hintStyle: TextStyle(
                color: textGrey,
                fontSize: 16,
                fontFamily: openSans,
                fontWeight: FontWeight.bold),
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
