import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';

class GeneralListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  const GeneralListItem({Key? key,required this.icon,required this.subtitle,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: openSans,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: subtitle!=null?Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Text(
            subtitle!,
            style: TextStyle(
              fontFamily: openSans,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ):null,
    );
  }
}
