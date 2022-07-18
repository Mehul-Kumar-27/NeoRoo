import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';
import '../../../utils/api_config.dart' as APIConfig;

class UserInfo extends StatelessWidget {
  final String? avatarId;
  final String name;
  final String id;
  final String baseURL;
  final String authHeaderValue;
  const UserInfo(
      {Key? key,
      required this.avatarId,
      required this.id,
      required this.name,
      required this.baseURL,
      required this.authHeaderValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      color: Color(0xff3080ED),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: avatarId == null
                ? Icon(
                    Icons.person,
                    color: Colors.blueGrey[300],
                    size: 35,
                  )
                : null,
            backgroundImage: avatarId != null
                ? NetworkImage(
                    baseURL + APIConfig.fileResources + "/$avatarId" + "/data",
                    headers: {
                        "authorization": authHeaderValue,
                      })
                : null,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        name,
                        style: TextStyle(
                          fontFamily: openSans,
                          color: white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        "Id: $id",
                        style: TextStyle(
                          fontFamily: openSans,
                          color: white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
