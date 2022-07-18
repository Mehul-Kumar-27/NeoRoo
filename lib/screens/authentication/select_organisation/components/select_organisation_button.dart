import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectOrganisationButton extends StatelessWidget {
  final void Function(String, String?) proceed;
  final String selectedId;
  final String? selectedOrgName;
  const SelectOrganisationButton(
      {Key? key,
      required this.proceed,
      required this.selectedId,
      required this.selectedOrgName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        proceed(selectedId, selectedOrgName);
      },
      child: Container(
        width: double.infinity,
        height: 55,
        margin: EdgeInsets.symmetric(
          horizontal: 29,
        ),
        alignment: Alignment.center,
        child: Text(
          AppLocalizations.of(context).proceed,
          style: TextStyle(
            fontFamily: openSans,
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: white,
          ),
        ),
        decoration: BoxDecoration(
          color: primaryBlue,
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
    );
  }
}
