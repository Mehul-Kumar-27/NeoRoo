import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateBabyButton extends StatelessWidget {
  final VoidCallback onPressed;
  const UpdateBabyButton({Key? key,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        width: double.infinity,
        height: 55,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        alignment: Alignment.center,
        child: Text(
          AppLocalizations.of(context).updateBabyDetails,
          style: TextStyle(
            fontFamily: openSans,
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: white,
          ),
        ),
        decoration: BoxDecoration(
          color: primaryBlue,
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
    );
  }
}