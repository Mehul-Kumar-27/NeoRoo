import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import 'package:neoroo_app/utils/api_config.dart' as APIConfig;

class SelectAccountListItem extends StatefulWidget {
  final String username;
  final String serverURL;
  final String? avatarId;
  final String name;
  final String password;
  final VoidCallback login;
  const SelectAccountListItem({
    Key? key,
    required this.avatarId,
    required this.serverURL,
    required this.username,
    required this.name,
    required this.password,
    required this.login,
  }) : super(key: key);

  @override
  State<SelectAccountListItem> createState() => _SelectAccountListItemState();
}

class _SelectAccountListItemState extends State<SelectAccountListItem> {
  bool _isError=false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      onTap: widget.login,
      leading: widget.avatarId == null||_isError
          ? CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey[300],
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 28,
              ),
            )
          : CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey[300],
              backgroundImage: NetworkImage(
                widget.serverURL + APIConfig.fileResources + "/${widget.avatarId!}" + "/data",
                headers: {
                  "authorization": APIConfig.authUtilFunction(
                    widget.username,
                    widget.password,
                  ),
                },
              ),
              onBackgroundImageError: (o,s){
                setState(() {
                  _isError=true;
                });
              },
            ),
      title: Text(
        widget.name,
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
            widget.serverURL,
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
