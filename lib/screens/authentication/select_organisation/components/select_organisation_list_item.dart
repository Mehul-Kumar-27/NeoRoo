import 'package:flutter/material.dart';
import 'package:neoroo_app/utils/constants.dart';

class SelectOrganisationListItem extends StatelessWidget {
  final String? name;
  final String id;
  final int value;
  final int groupValue;
  final void Function(int?) onChange;
  final VoidCallback onTap;
  const SelectOrganisationListItem({
    Key? key,
    required this.groupValue,
    required this.id,
    required this.name,
    required this.value,
    required this.onChange,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      onTap: onTap,
      title: Text(
        name == null ? id : name!,
        style: TextStyle(
          color: Colors.black,
          fontFamily: openSans,
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Text(
            id,
            style: TextStyle(
              color: name == null ? transparent : outlineGrey,
              decorationColor: name == null ? transparent : outlineGrey,
            ),
          ),
        ],
      ),
      leading: Radio(
        value: value,
        groupValue: groupValue,
        onChanged: onChange,
      ),
    );
  }
}
