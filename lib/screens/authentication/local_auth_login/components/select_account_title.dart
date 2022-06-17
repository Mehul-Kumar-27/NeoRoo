import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectAccountTitle extends StatelessWidget {
  const SelectAccountTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Text(
        AppLocalizations.of(context).chooseSavedProfile,
        style: TextStyle(
          fontFamily: openSans,
          fontSize: 22,
        ),
      ),
    );
  }
}
