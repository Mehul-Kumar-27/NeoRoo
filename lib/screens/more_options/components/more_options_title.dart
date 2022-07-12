import 'dart:math';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';

class MoreOptionsTitle extends StatelessWidget {
  const MoreOptionsTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      alignment: min(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height) >
        600?null:Alignment.centerLeft,
      child: Text(
        AppLocalizations.of(context).moreOptions,
        style: TextStyle(
          fontFamily: openSans,
          color: primaryBlue,
          fontSize: min(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height) >
        600?25:20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
//font-size: 20 for mobile, 25 for tablet
//alignment: centerLeft for mobile
