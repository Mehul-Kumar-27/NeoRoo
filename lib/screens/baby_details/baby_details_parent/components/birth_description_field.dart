import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BirthDescriptionField extends StatelessWidget {
  final TextEditingController birthDescription;
  const BirthDescriptionField({Key? key, required this.birthDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryBlue,
                width: 1.5,
              ),
            ),
            child: TextField(
              cursorColor: primaryBlue,
              controller: birthDescription,
              textAlignVertical: TextAlignVertical.center,
              enabled: false,
              minLines: 3,
              maxLines: 3,
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
                hintText: AppLocalizations.of(context).birthDescription,
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
