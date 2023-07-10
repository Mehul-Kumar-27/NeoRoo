import 'dart:math';

import 'package:flutter/material.dart';

class LoginHolder extends StatelessWidget {
  final List<Widget> children;
  const LoginHolder({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (min(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height) >
        600) {
      return Center(
        child: LayoutBuilder(
          builder: (context, constraint) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraint.maxHeight * 0.50,
                maxWidth: 600,
              ),
              child: Container(
                child: IntrinsicHeight(
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
