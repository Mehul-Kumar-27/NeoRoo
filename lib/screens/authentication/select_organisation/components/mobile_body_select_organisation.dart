import 'package:flutter/material.dart';
import 'package:neoroo_app/screens/authentication/select_organisation/components/select_organisation_button.dart';
import 'package:neoroo_app/screens/authentication/select_organisation/components/select_organisation_list_item.dart';
import 'package:neoroo_app/screens/authentication/select_organisation/components/select_organisation_title.dart';
import 'package:neoroo_app/utils/vertical_space.dart';

class MobileBodySelectOrganisation extends StatelessWidget {
  final void Function(String,String?) proceed;
  final List<String?> orgIdList;
  final int groupValue;
  final List<String?> orgNameList;
  final void Function(int?) onChange;
  const MobileBodySelectOrganisation({
    Key? key,
    required this.proceed,
    required this.orgIdList,
    required this.orgNameList,
    required this.groupValue,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpace(
          height: 20,
        ),
        SelectOrganisationTitle(),
        VerticalSpace(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => SelectOrganisationListItem(
              groupValue: groupValue,
              id: orgIdList[index]!,
              name: orgNameList[index],
              value: index,
              onChange: onChange,
              onTap: () {
                onChange(index);
              },
            ),
            itemCount: orgIdList.length,
          ),
        ),
        SelectOrganisationButton(
          proceed: proceed,
          selectedId: orgIdList[groupValue]!,
          selectedOrgName: orgNameList[groupValue],
        ),
        VerticalSpace(
          height: 10,
        ),
      ],
    );
  }
}
