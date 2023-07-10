import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsItem extends StatelessWidget {
  const NotificationsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.notifications,
      ),
      title: Text(
        AppLocalizations.of(context).notifications,
        style: TextStyle(
          fontFamily: openSans,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Switch(
        value: true,
        onChanged: (value) {},
        activeColor: Colors.grey[50],
        activeTrackColor: Colors.lightGreen,
      ),
    );
  }
}
