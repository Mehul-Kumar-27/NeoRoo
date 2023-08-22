import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';

class MoreOptionsTitle extends StatelessWidget implements PreferredSizeWidget {
  const MoreOptionsTitle({Key? key}) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      elevation: 2,
      title: Text(
        AppLocalizations.of(context).moreOptions,
        style: TextStyle(
          fontFamily: openSans,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      backgroundColor: white,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
