import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeadCircumferenceField extends StatefulWidget {
  final TextEditingController headCircumference;
  final double headCircumferenceValue;
  const HeadCircumferenceField({Key? key, required this.headCircumference,required this.headCircumferenceValue})
      : super(key: key);

  @override
  State<HeadCircumferenceField> createState() => _HeadCircumferenceFieldState();
}

class _HeadCircumferenceFieldState extends State<HeadCircumferenceField> {
  bool _isInches = false;
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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: primaryBlue,
                    textAlignVertical: TextAlignVertical.center,
                    controller: widget.headCircumference,
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
                      hintText: AppLocalizations.of(context).headCircumference,
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isInches = !_isInches;
                      if (_isInches) {
                        widget.headCircumference.text =
                            (widget.headCircumferenceValue / 2.54).toStringAsFixed(1);
                      } else {
                        widget.headCircumference.text = widget.headCircumferenceValue.toString();
                      }
                    });
                  },
                  child: Container(
                    height: 37.5,
                    width: 37.5,
                    margin: EdgeInsets.only(
                      right: 5,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _isInches ? "inch" : "cm",
                      style: TextStyle(
                        color: white,
                        fontFamily: openSans,
                      ),
                    ),
                    color: primaryBlue,
                  ),
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
