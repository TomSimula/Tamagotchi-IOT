import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../services/rest.dart';

class Sensor extends StatefulWidget {
  const Sensor({super.key});

  @override
  State<Sensor> createState() => SensorState();

}

class SensorState extends State<Sensor> {
  Map<String, List<double>> values = {};
  Map<String, dynamic> sensorInfo = {};
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
      //update sensor info
      sensorInfo = await RestService().getSensor();
      setState(() {
        //update values sensor for graph
        sensorInfo.forEach((key, value) {
          sensorInfo[key]?.forEach((subKey, subValue) {
            if(subKey=="value"){
              String? pin = sensorInfo[key]?["pin"].toString();
              if (values.containsKey(pin)){
                var list = values[pin];
                if(list?.length == 10){
                  list?.removeAt(0);
                }
                list?.add(subValue);
              } else {
                values[pin!] = [subValue];
              }
            }
          });
        });
      });
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('plant_sensor_detector'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction == 0) {
          // Widget is not visible, stop the timer
          stopTimer();
        } else {
          // Widget is visible, start or restart the timer
          startTimer();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Sensor"),
          ),
          body: ListView.builder(
            itemCount: sensorInfo.length,
            itemBuilder: (context, index){
              final key = sensorInfo.keys.elementAt(index);
              final Map<String, dynamic> info = sensorInfo[key];
              List<Widget> columnInfo = info.entries.where((entry) {
                // Constraint to avoid to Text the value (keep it for the graph)
                return entry.key != 'value';
              })
                  .map((MapEntry<String, dynamic> entry) {
                return ListTile(title: Text("${entry.key}: ${entry.value}", style: const TextStyle(fontSize: 20),),);
              }).toList();

              if(info.containsKey("value")){
                if(!values.containsKey(info["pin"].toString())){
                  values[info["pin"].toString()] = [];
                }
                columnInfo.add(createGraph(values[info["pin"].toString()]!));
              }

              return Card(
                color: const Color(0xFF976b48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: columnInfo,
                )
              );
            }
          ),
      ),
    );
  }

  Widget createGraph(List<double> points){
    List<Color> gradientColors = [
      Colors.cyan,
      Colors.blue,
    ];
    double counter = 0;

    return ListTile(
      title: AspectRatio(
        aspectRatio: 1.70,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 18,
            left: 12,
            top: 24,
            bottom: 12,
          ),
          child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 1,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return const FlLine(
                      color: Colors.black38,
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return const FlLine(
                      color: Colors.black38,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: const FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      reservedSize: 42,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: const Color(0xff37434d)),
                ),
                minX: 0,
                maxX: 10,
                lineBarsData: [
                  LineChartBarData(
                    spots: points.map((y) {
                      final result = FlSpot(counter,y);
                      counter++;
                      return result;
                    }).toList(),
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: gradientColors,
                    ),
                    barWidth: 5,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(
                      show: true,
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }

}