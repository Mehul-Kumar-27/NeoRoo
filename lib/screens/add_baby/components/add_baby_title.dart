import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddBabyTitle extends StatelessWidget
    with PreferredSizeWidget {
  const AddBabyTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      leadingWidth: 20,
      title: Container(
        child: Text(
          AppLocalizations.of(context).babyBirthDetails,
          style: TextStyle(
            fontFamily: openSans,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: white,
      titleSpacing: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
