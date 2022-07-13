import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BabyDetailsFamilyMemberTitleId extends StatelessWidget {
  final String id;
  const BabyDetailsFamilyMemberTitleId({Key? key,required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 15,
          ),
          child: Text(
            AppLocalizations.of(context).babyBirthDetails,
            style: TextStyle(
              fontFamily: openSans,
              color: primaryBlue,
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            right: 15,
          ),
          child: Text(
            "ID: $id",
            style: TextStyle(
              fontFamily: openSans,
              color: primaryBlue,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
