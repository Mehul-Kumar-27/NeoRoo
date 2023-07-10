import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: "Don't have an account ? ",
            style: TextStyle(
                fontFamily: lato,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: black),
            children: <TextSpan>[
          TextSpan(
            text: "Sign Up",
            style: TextStyle(
                fontFamily: lato,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: themepurple),
          )
        ]));
  }
}
