//screen just to show user has logged in
import 'package:flutter/material.dart';

class TempScreen extends StatelessWidget {
  const TempScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            "Log In Successful",
          ),
        ),
      ),
    );
  }
}
