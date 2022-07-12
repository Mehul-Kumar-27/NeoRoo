import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';

class MoreOptionsItem extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const MoreOptionsItem({Key? key,required this.onPressed,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: min(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height) >
                600
            ? 600
            : double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        height: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: primaryBlue.withOpacity(0.5),
              blurRadius: 1,
              offset: Offset(
                0,
                2,
              ),
            ),
            BoxShadow(
              color: primaryBlue.withOpacity(0.5),
              blurRadius: 1,
              offset: Offset(
                2,
                0,
              ),
            ),
          ],
        ),
        child: Card(
          margin: EdgeInsets.zero,
          child: Row(
            children: [
              SizedBox(
                height: 100,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: TextStyle(
                  fontFamily: openSans,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//for mobile width: double.infinity