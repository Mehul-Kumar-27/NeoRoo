import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateBabyBirthDescription extends StatelessWidget {
  final TextEditingController description;
  const UpdateBabyBirthDescription(
      {Key? key, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).birthDescription,
            style: TextStyle(
              fontFamily: openSans,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            cursorColor: primaryBlue,
            minLines: 4,
            maxLines: 4,
            controller: description,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              hintText: AppLocalizations.of(context).birthDescription,
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: outlineGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
