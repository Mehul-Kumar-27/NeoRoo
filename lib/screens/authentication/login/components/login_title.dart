import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TitleLogin extends StatelessWidget {
  const TitleLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        // AppLocalizations.of(context).title,
        "Essential Neonatal Care",
        style: TextStyle(
          fontFamily: lato,
          color: secondaryOrange,
          fontWeight: FontWeight.bold,
          wordSpacing: 1,
          fontSize: 20,
        ),
      ),
    );
  }
}
