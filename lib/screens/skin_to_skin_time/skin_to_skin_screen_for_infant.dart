// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:neoroo_app/models/infant_model.dart';
import 'package:neoroo_app/screens/skin_to_skin_time/graph.dart';
import 'package:neoroo_app/screens/skin_to_skin_time/graph_header.dart';
import 'package:neoroo_app/screens/skin_to_skin_time/linear_calendar.dart';
import 'package:neoroo_app/utils/constants.dart';

class SkinToSkinScreenForInfant extends StatelessWidget {
  final Infant infant;
  const SkinToSkinScreenForInfant({
    Key? key,
    required this.infant,
    required this.mapData,
  }) : super(key: key);

  final List<List<Data>> mapData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: purpleTheme,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.white,
                )),
            Text(
              'Skin - Skin Activity',
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          LinearCalendarWidget(
            infant: infant,
          ),
          const SizedBox(
            height: 29,
          ),
          GraphHeader(),
          ChartWidget(data: mapData)
        ],
      ),
    );
  }
}
