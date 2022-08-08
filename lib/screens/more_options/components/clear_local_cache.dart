import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:neoroo_app/utils/constants.dart';

class ClearLocalCache extends StatelessWidget {
  const ClearLocalCache({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.delete_forever,
      ),
      title: Text(
        AppLocalizations.of(context).clearLocalCache,
        style: TextStyle(
          fontFamily: openSans,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Text(
            AppLocalizations.of(context).thisActionCannotBeUndone,
            style: TextStyle(
              fontFamily: openSans,
              fontWeight: FontWeight.w300,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
