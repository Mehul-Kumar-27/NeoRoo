import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogOutButton extends StatelessWidget {
  final VoidCallback onTap;
  const LogOutButton({Key? key,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        Icons.power_settings_new,
        color: Colors.red[500],
      ),
      title: Text(
        AppLocalizations.of(context).signOut,
        style: TextStyle(
          fontFamily: openSans,
          fontWeight: FontWeight.w600,
          color: Colors.red[500],
        ),
      ),
    );
  }
}
