import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';

class AddBabyAvatarMethod extends StatelessWidget {
  final IconData icon;
  final Color textColor;
  final String methodName;
  final VoidCallback onPressed;
  const AddBabyAvatarMethod({
    Key? key,
    required this.icon,
    required this.textColor,
    required this.methodName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Icon(
            icon,
            color: outlineGrey,
            size: 35,
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            methodName,
            style: TextStyle(
              fontFamily: openSans,
              color: textColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
