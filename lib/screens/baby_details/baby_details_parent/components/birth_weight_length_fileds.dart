import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BirthWeightLengthFieldsParent extends StatefulWidget {
  final TextEditingController birthWeight;
  final double weight;
  final double length;
  final TextEditingController bodyLength;
  const BirthWeightLengthFieldsParent(
      {Key? key,
      required this.bodyLength,
      required this.birthWeight,
      required this.length,
      required this.weight})
      : super(key: key);

  @override
  State<BirthWeightLengthFieldsParent> createState() =>
      _BirthWeightLengthFieldsParentState();
}

class _BirthWeightLengthFieldsParentState
    extends State<BirthWeightLengthFieldsParent> {
  bool _isGram = true;
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
                    controller: widget.birthWeight,
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
                      hintText: AppLocalizations.of(context).birthWeight,
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
                      _isGram = !_isGram;
                      if (_isGram) {
                        widget.birthWeight.text = widget.weight.toString();
                      } else {
                        widget.birthWeight.text =
                            (widget.weight / 453.6).toStringAsFixed(1);
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
                      _isGram ? "g" : "lbs",
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
                    textAlignVertical: TextAlignVertical.center,
                    controller: widget.bodyLength,
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
                      hintText: AppLocalizations.of(context).bodyLength,
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
                        widget.bodyLength.text=(widget.length/2.54).toStringAsFixed(1);
                      } else {
                        widget.bodyLength.text =widget.length.toString();
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
