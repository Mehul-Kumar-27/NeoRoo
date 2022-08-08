import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SwitchOrganization extends StatelessWidget {
  const SwitchOrganization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.location_city,
      ),
      title: Text(
        AppLocalizations.of(context).switchOrganization,
        style: TextStyle(
          fontFamily: openSans,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
