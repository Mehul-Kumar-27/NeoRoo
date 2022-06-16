import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ServerURLFieldLogin extends StatelessWidget {
  final TextEditingController controller;
  const ServerURLFieldLogin({Key? key,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.url,
        cursorColor: primaryBlue,
        decoration: InputDecoration(
          prefixIcon: Icon(
            CupertinoIcons.globe,
            color: outlineGrey,
          ),
          hintText: AppLocalizations.of(context).serverURL,
          hintStyle: TextStyle(
            color: outlineGrey,
            fontFamily: openSans,
            fontSize: 16,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryBlue,
              width: 1.75,
            ),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: outlineGrey,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
