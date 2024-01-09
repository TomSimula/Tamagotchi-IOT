import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tamagotchi/pages/Home/settings_dialog.dart';
import 'dart:async';
import 'package:visibility_detector/visibility_detector.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Plant'),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                child: const Image(
                    image: AssetImage('assets/MyPlantV2.png')
                ),
              )
          ),
          const Expanded(
              flex: 4,
              child: PlantValue()
          ),
          Expanded(
              flex: 1,
              child: Container(
                width: 400,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBF6EE),
                  borderRadius: BorderRadius.circular(20.0), // Set the radius here
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                      IconButton(
                        padding: const EdgeInsets.only(bottom: 1),
                        onPressed: (){
                          showSliderDialog(context);
                        },
                        icon: const Icon(
                          Icons.settings,
                          size: 40,
                        )
                      ),
                      ElevatedButton(
                          onPressed: () {
                            //TODO
                          },
                          child: const Text("Comment ca va?")
                      ),
                      IconButton(
                        padding: const EdgeInsets.only(bottom: 1),
                        onPressed: (){
                          Navigator.pushNamed(context, '/analytics');
                        },
                        icon: const Icon(
                          Icons.analytics_rounded,
                          size: 40,
                        )
                      )
                    ]
                )
              )
          ),
        ],
      ),
    );
  }

  void showSliderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SettingsDialog();
      },
    );
  }

}

class PlantValue extends StatefulWidget {
  const PlantValue({super.key});

  @override
  State<PlantValue> createState() => PlantValueState();
}

class PlantValueState extends State<PlantValue> {

  double waterMarker = 0;
  double temperatureMarker = 0;
  double lightMarker = 0;
  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      // Update plant value every second
      setState(() {

      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: const Key('plant_value_detector'),
        onVisibilityChanged: (VisibilityInfo info) {
          if (info.visibleFraction == 0) {
            // Widget is not visible, stop the timer
            _stopTimer();
          } else {
            // Widget is visible, start or restart the timer
            _startTimer();
          }
        },
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: createProgressBar("Water")
          ),
          Expanded(
              flex: 1,
              child: createProgressBar("Temperature")
          ),
          Expanded(
              flex: 1,
              child: createProgressBar("Light")
          )
        ],
      ),
    );
  }
  
  //Progress bar 
  Container createProgressBar(String valueName){
    return Container(
        margin: const EdgeInsets.all(10.0),
        child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  valueName,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              SfLinearGauge(
                orientation: LinearGaugeOrientation.horizontal,
                showAxisTrack: false,
                showLabels: false,
                showTicks: false,
                minimum: 0,
                maximum: 6,
                //Bar's part
                ranges: <LinearGaugeRange>[
                  LinearGaugeRange(
                    startValue: 0,
                    endValue: 2,
                    startWidth: 10,
                    endWidth: 10,
                    child: createFadeContainer([Colors.red[600]!, Colors.red, Colors.red[300]!, Colors.yellow])
                  ),
                  LinearGaugeRange(
                    startValue: 2,
                    endValue: 4,
                    startWidth: 10,
                    endWidth: 10,
                    child: createFadeContainer([Colors.yellow, Colors.yellow[300]!])
                  ),
                  LinearGaugeRange(
                    startValue: 4,
                    endValue: 6,
                    startWidth: 10,
                    endWidth: 10,
                    child: createFadeContainer([Colors.yellow[300]!, Colors.green[300]!, Colors.green, Colors.green[600]!])
                  ),
                ],
                //Bar's marker
                markerPointers: <LinearShapePointer>[
                  LinearShapePointer(
                    value: temperatureMarker,
                    width: 10,
                    height: 20,
                    position: LinearElementPosition.outside,
                    shapeType: LinearShapePointerType.rectangle,
                    color: Colors.black,
                  ),
                ],
              )
            ]
        )
    );
  }

  Container createFadeContainer(List<Color> colors){
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
}
