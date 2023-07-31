import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String heading;
  final String data;
  const TextWidget({
    Key? key,
    required this.heading,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: heading,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            children: [
          TextSpan(
              text: data,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.normal))
        ]));
  }
}
