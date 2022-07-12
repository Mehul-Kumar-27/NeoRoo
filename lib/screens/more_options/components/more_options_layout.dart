import 'package:flutter/material.dart';
import 'package:neoroo_app/screens/more_options/components/more_options_title.dart';
import 'dart:math';

import 'package:neoroo_app/utils/vertical_space.dart';

class MoreOptionsLayout extends StatelessWidget {
  final List<Widget> children;
  const MoreOptionsLayout({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isTablet = min(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height) >
        600;
    if (isTablet) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
          ),
          VerticalSpace(
            height: 30,
          ),
          Align(
            alignment: Alignment.center,
            child: MoreOptionsTitle(),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => VerticalSpace(
                height: 20,
              ),
              itemBuilder: (context, index) => index == children.length
                  ? SizedBox(
                      height: 20,
                    )
                  : children[index],
              itemCount: children.length + 1,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 20,
            ),
            child: MoreOptionsTitle(),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => index==children.length?SizedBox(
                height: 20,
              ):children[index],
              separatorBuilder: (context, index) => VerticalSpace(
                height: 20,
              ),
              itemCount: children.length+1,
            ),
          ),
        ],
      );
    }
  }
}
