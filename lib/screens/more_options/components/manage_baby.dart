import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ManageBaby extends StatelessWidget {
  final bool isCaregiver;
  final VoidCallback onTap;
  const ManageBaby({Key? key, required this.isCaregiver, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        Icons.child_friendly,
      ),
      title: Text(
        isCaregiver
            ? AppLocalizations.of(context).addUpdateDetails
            : AppLocalizations.of(context).babyBirthDetails,
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
            isCaregiver
                ? AppLocalizations.of(context).manageBabyDetails
                : AppLocalizations.of(context).viewBabyDetails,
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
