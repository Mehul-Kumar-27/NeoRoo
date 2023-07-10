import 'dart:math';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: min(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height) >
                    600
                ? 300
                : 200,
          ),
          child: Container(
            width: double.infinity,
            child: Image.asset(
              "assets/error_loading.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context).errorPageMessage,
            style: TextStyle(
              fontFamily: openSans,
              fontWeight: FontWeight.w600,
              fontSize: 21,
            ),
          ),
        ),
      ],
    );
  }
}
