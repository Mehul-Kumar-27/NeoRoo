import 'dart:math';
import 'package:flutter/material.dart';

class SelectOrganisationLayout extends StatelessWidget {
  final List<Widget> children;
  const SelectOrganisationLayout({Key? key, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (min(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height) >
        600) {
      return Center(
        child: LayoutBuilder(
          builder: (context, constraint) => Container(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 700,
                maxWidth: 600,
                maxHeight: 700,
              ),
              child: Card(
                child: Container(
                  height: constraint.maxHeight,
                  child: Column(
                    children: this.children,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return LayoutBuilder(
        builder: (context, constraint) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: children,
              ),
            ),
          ),
        ),
      );
    }
  }
}
