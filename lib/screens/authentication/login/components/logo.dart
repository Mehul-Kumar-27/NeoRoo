import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';

class LogoLogin extends StatelessWidget {
  const LogoLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 40,
      ),
      height: MediaQuery.of(context).size.height * 0.30,
      color: transparent,
      width: double.infinity,
      child: Image.asset(
        logoPath,
      ),
    );
  }
}
