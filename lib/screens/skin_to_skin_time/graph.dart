// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatefulWidget {
  final List<List<Data>> data;

  ChartWidget({required this.data});

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  String getWeekDayName(String dateString) {
    DateTime date = DateTime.parse(dateString);
    if (date.weekday == DateTime.sunday) {
      return "Sun";
    } else if (date.weekday == DateTime.monday) {
      return "Mon";
    } else if (date.weekday == DateTime.tuesday) {
      return "Tue";
    } else if (date.weekday == DateTime.wednesday) {
      return "Wed";
    } else if (date.weekday == DateTime.thursday) {
      return "Thu";
    } else if (date.weekday == DateTime.friday) {
      return "Fri";
    } else if (date.weekday == DateTime.saturday) {
      return "Sat";
    } else {
      return "Sun";
    }
  }

  List<Data> goalDataList = [];
  double totalSkinToSkin = 0;
  double totalNSkinToSkin = 0;

  List<Data> prepareGoalGraph(List<Data> dataList) {
    List<Data> goalData = [];
    for (var element in dataList) {
      String dateOfElement = element.date;
      Data newData = Data(date: dateOfElement, hours: 4);
      goalData.add(newData);
    }
    return goalData;
  }

  getTotalKMCHours(List<List<Data>> kmcList) {
    List<Data> skinToSkinList = kmcList[1];
    List<Data> nskinToSkinList = kmcList[0];

    for (var element in skinToSkinList) {
      setState(() {
        totalSkinToSkin = totalNSkinToSkin + element.hours;
      });
    }

    for (var element in nskinToSkinList) {
      setState(() {
        totalNSkinToSkin = totalNSkinToSkin + element.hours;
      });
    }
  }

  @override
  void initState() {
    setState(() {
      goalDataList = prepareGoalGraph(widget.data[1]);
    });
    getTotalKMCHours(widget.data);

    super.initState();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                bottom: 17.0, left: 18, right: 18, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 43.0),
                  child: Text(
                    'Hours',
                    style: TextStyle(
                        fontFamily: "Roboto Mono",
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                TotalKmcHoursWidget(
                  totalSkinToSkin: totalSkinToSkin,
                  totalNSkinToSkin: totalNSkinToSkin,
                )
              ],
            ),
          ),
          SizedBox(
            height: 300,
            child: SfCartesianChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              legend: Legend(isVisible: true, position: LegendPosition.bottom),
              backgroundColor: Colors.white,
              primaryXAxis: CategoryAxis(
                  title:
                      AxisTitle(text: "Days", alignment: ChartAlignment.far)),
              primaryYAxis: NumericAxis(
                maximum: 24,
                minimum: 0,
                interval: 2,
              ),
              series: <ChartSeries>[
                LineSeries<Data, String>(
                  markerSettings:
                      MarkerSettings(height: 2, width: 2, isVisible: true),
                  color: Color.fromRGBO(110, 42, 127, 1),
                  name: "Skin-Skin",
                  isVisibleInLegend: false,
                  dataSource: widget.data[1],
                  xValueMapper: (Data data, _) => getWeekDayName(data.date),
                  yValueMapper: (Data data, _) => data.hours,
                ),
                LineSeries<Data, String>(
                  isVisibleInLegend: false,
                  markerSettings:
                      MarkerSettings(height: 2, width: 2, isVisible: true),
                  color: Color.fromRGBO(196, 196, 196, 1),
                  name: "Non Skin-Skin",
                  dataSource: widget.data[0],
                  xValueMapper: (Data data, _) => getWeekDayName(data.date),
                  yValueMapper: (Data data, _) => data.hours,
                ),
                LineSeries<Data, String>(
                  color: Color.fromRGBO(134, 101, 49, 1),
                  name: "Goal",
                  dataSource: goalDataList,
                  xValueMapper: (Data data, _) => getWeekDayName(data.date),
                  yValueMapper: (Data data, _) => data.hours,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TotalKmcHoursWidget extends StatelessWidget {
  const TotalKmcHoursWidget({
    Key? key,
    required this.totalSkinToSkin,
    required this.totalNSkinToSkin,
  }) : super(key: key);

  final double totalSkinToSkin;
  final double totalNSkinToSkin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 173,
      height: 60,
      decoration: BoxDecoration(color: Color.fromRGBO(239, 231, 243, 1)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 13),
            child: Row(
              children: [
                Text(
                  "Total KMC hours",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13.0, right: 13, top: 10),
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(110, 42, 127, 1)),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text("$totalSkinToSkin")
                  ],
                ),
                SizedBox(
                  width: 11,
                ),
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(196, 196, 196, 1)),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text("$totalNSkinToSkin")
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Data {
  final String date;
  final double hours;

  Data({required this.date, required this.hours});
}
