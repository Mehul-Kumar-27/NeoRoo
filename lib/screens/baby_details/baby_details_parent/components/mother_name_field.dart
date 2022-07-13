import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MothersNameTextField extends StatelessWidget {
  final TextEditingController motherName;
  const MothersNameTextField({Key? key,required this.motherName}) : super(key: key);

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
              controller: motherName,
              enabled: false,
              textAlignVertical: TextAlignVertical.center,
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
                hintText: AppLocalizations.of(context).motherName,
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
