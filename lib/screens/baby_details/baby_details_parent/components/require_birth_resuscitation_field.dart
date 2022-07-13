import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequireBirthResuscitationField extends StatelessWidget {
  final TextEditingController requireBirthResuscitation;
  const RequireBirthResuscitationField({Key? key,required this.requireBirthResuscitation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryBlue,
                width: 1.5,
              ),
            ),
            child: TextField(
              cursorColor: primaryBlue,
              textAlignVertical: TextAlignVertical.center,
              controller: requireBirthResuscitation,
              enabled: false,
              style: TextStyle(
                color: Colors.black,
                fontFamily: openSans,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontFamily: openSans,
                  color: outlineGrey,
                  fontSize: 15,
                ),
                suffixIcon: Icon(
                  CupertinoIcons.chevron_down,
                  color: primaryBlue,
                ),
                hintText: AppLocalizations.of(context).requireBirthResuscitation,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 15,
            ),
          ),
        ),
      ],
    );
  }
}
