import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeAvatar extends StatelessWidget {
  const ChangeAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.camera_alt_outlined,
      ),
      title: Text(
        AppLocalizations.of(context).changeAvatar,
        style: TextStyle(
          fontFamily: openSans,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
