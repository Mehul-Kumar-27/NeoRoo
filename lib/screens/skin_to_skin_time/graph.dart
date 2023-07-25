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

  List<Data> goalDataList=  [];

  List<Data> prepareGoalGraph(List<Data> dataList) {
    List<Data> goalData = [];
    for (var element in dataList) {
      String dateOfElement = element.date;
      Data newData = Data(date: dateOfElement, hours: 4);
      goalData.add(newData);
    }
    return goalData;
  }

  @override
  void initState() {
    setState(() {
       goalDataList = prepareGoalGraph(widget.data[1]);
    });
   
    super.initState();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 17.0, left: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Hours',
                  style: TextStyle(
                      fontFamily: "Roboto Mono",
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
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
                  title: AxisTitle(text: "Day", alignment: ChartAlignment.far)),
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
                  color: Colors.grey.shade500,
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

class Data {
  final String date;
  final int hours;

  Data({required this.date, required this.hours});
}
