import 'package:flutter/material.dart';
import 'package:neoroo_app/screens/skin_to_skin_time/graph.dart';
import 'package:neoroo_app/screens/skin_to_skin_time/graph_header.dart';

import 'package:neoroo_app/screens/skin_to_skin_time/linear_calendar.dart';

class SkinToSkinTimeScreen extends StatefulWidget {
  const SkinToSkinTimeScreen({Key? key}) : super(key: key);

  @override
  State<SkinToSkinTimeScreen> createState() => _SkinToSkinTimeScreenState();
}

class _SkinToSkinTimeScreenState extends State<SkinToSkinTimeScreen> {
  List<Data> data1 = [
    Data(date: '2023-07-23', hours: 8),
    Data(date: '2023-07-24', hours: 14),
    Data(date: '2023-07-25', hours: 10),
    Data(date: '2023-07-26', hours: 6),
    Data(date: '2023-07-27', hours: 12),
    Data(date: '2023-07-28', hours: 9),
    Data(date: '2023-07-29', hours: 7),
  ];
  List<Data> data2 = [
    Data(date: '2023-07-23', hours: 12),
    Data(date: '2023-07-24', hours: 15),
    Data(date: '2023-07-25', hours: 19),
    Data(date: '2023-07-26', hours: 7),
    Data(date: '2023-07-27', hours: 13),
    Data(date: '2023-07-28', hours: 22),
    Data(date: '2023-07-29', hours: 24),
  ];

  late List<List<Data>> mapData;
  @override
  void initState() {
    mapData = [data1, data2];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(110, 42, 127, 1),
        title: Text('Skin - Skin Activity'),
      ),
      body: ListView(
        children: [
          LinearCalendarWidget(),
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
