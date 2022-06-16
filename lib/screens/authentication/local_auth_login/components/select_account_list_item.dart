import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';

class SelectAccountListItem extends StatelessWidget {
  final String username;
  final String serverURL;
  final String? image;
  final String name;
  final String password;
  final VoidCallback login;
  const SelectAccountListItem({
    Key? key,
    required this.image,
    required this.serverURL,
    required this.username,
    required this.name,
    required this.password,
    required this.login,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      onTap: login,
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.grey[300],
        child: Icon(
          Icons.person,
          color: Colors.white,
          size: 28,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          color: Colors.black,
          fontFamily: openSans,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Text(
            serverURL,
            style: TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.underline,
              decorationColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
