import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BirthDateTimeFieldsParent extends StatelessWidget {
  final TextEditingController birthDate;
  final TextEditingController birthTime;
  const BirthDateTimeFieldsParent(
      {Key? key, required this.birthDate, required this.birthTime})
      : super(key: key);

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
              controller: birthDate,
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
                hintText: AppLocalizations.of(context).birthDate,
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
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.015,
        ),
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryBlue,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: primaryBlue,
                    enabled: false,
                    textAlignVertical: TextAlignVertical.center,
                    controller: birthTime,
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
                      hintText: AppLocalizations.of(context).birthTime,
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
                ),
                Container(
                  height: 37.5,
                  width: 37.5,
                  margin: EdgeInsets.only(
                    right: 5,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "hrs",
                    style: TextStyle(
                      color: white,
                      fontFamily: openSans,
                    ),
                  ),
                  color: primaryBlue,
                ),
              ],
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
