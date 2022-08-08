import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';

class BabyDetailsAvatar extends StatelessWidget {
  final String? imageURL;
  final String auth;
  const BabyDetailsAvatar(
      {Key? key, required this.imageURL, required this.auth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 75,
          backgroundColor: primaryBlue,
          child: CircleAvatar(
            radius: 73,
            backgroundColor: Colors.white,
            child: imageURL == null
                ? Image.asset(
                    "assets/baby_placeholder.png",
                  )
                : null,
            backgroundImage: imageURL == null
                ? null
                : NetworkImage(
                    imageURL!,
                    headers: {
                      "authorization": auth,
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
