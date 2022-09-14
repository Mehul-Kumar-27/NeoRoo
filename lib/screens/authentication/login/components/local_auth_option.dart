import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neoroo_app/utils/constants.dart';

class LocalAuthOption extends StatelessWidget {
  final VoidCallback onPressed;
  const LocalAuthOption({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        height: 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: secondaryOrange.withOpacity(
            0.15,
          ),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Text(
          AppLocalizations.of(context).continueWithLocalAuth,
          style: TextStyle(
            fontFamily: openSans,
            color: secondaryOrange.withOpacity(0.9),
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
