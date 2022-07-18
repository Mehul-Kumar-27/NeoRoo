import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';

class OrganisationName extends StatelessWidget {
  final String orgName;
  final String orgId;
  const OrganisationName({Key? key, required this.orgName, required this.orgId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.local_hospital,
      ),
      title: Text(
        orgName,
        style: TextStyle(
          fontFamily: openSans,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Text(
            "Org Id: $orgId",
            style: TextStyle(
              fontFamily: "Open Sans",
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
