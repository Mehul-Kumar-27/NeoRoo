import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeadCircumferenceLabel extends StatelessWidget {
  const HeadCircumferenceLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 15,
        top: 15,
      ),
      child: Text(
        AppLocalizations.of(context).headCircumference,
        style: TextStyle(
          fontFamily: openSans,
          color: primaryBlue,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
