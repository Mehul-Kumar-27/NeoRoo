import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectOrganisationTitle extends StatelessWidget {
  const SelectOrganisationTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Text(
        AppLocalizations.of(context).chooseOrganisation,
        style: TextStyle(
          fontFamily: openSans,
          fontSize: 22,
        ),
      ),
    );
  }
}
