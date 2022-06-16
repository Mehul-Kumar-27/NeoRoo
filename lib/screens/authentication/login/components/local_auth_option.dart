import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neoroo_app/utils/constants.dart';

class LocalAuthOption extends StatelessWidget {
  final VoidCallback onPressed;
  const LocalAuthOption({Key? key,required this.onPressed,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        primary: secondaryOrange,
        padding: EdgeInsets.zero,
      ),
      child: Container(
        child: Text(
          AppLocalizations.of(context).continueWithLocalAuth,
          style: TextStyle(
            fontFamily: openSans,
            color: secondaryOrange,
            fontWeight: FontWeight.w400,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
