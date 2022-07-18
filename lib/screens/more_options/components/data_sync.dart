import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DataSync extends StatelessWidget {
  const DataSync({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.sync,
      ),
      title: Text(
        AppLocalizations.of(context).dataSync,
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
            AppLocalizations.of(context).makeSureYouHaveLatestData,
            style: TextStyle(
              fontFamily: openSans,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
