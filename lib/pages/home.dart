import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
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
        backgroundColor: const Color(0xFFFFC051),
      ),
      body: Container(
          color: const Color(0xFFA3EE97),
          child: Column(
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
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBF6EE),
                      borderRadius: BorderRadius.circular(20.0), // Set the radius here
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                          IconButton(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 1),
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

                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: const Color(0xFF65B741), // Text color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0), // Button border radius
                                ),
                              ),
                              child: const Text("Comment ca va?")
                          ),
                          IconButton(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 1),
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
          )
      ),
    );
  }

  void showSliderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SliderDialog();
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

  double temperatureValue = 0;
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
              child: getStatBar()
          ),
          Expanded(
              flex: 1,
              child: getStatBar()
          ),
          Expanded(
              flex: 1,
              child: getStatBar()
          )
        ],
      ),
    );
  }

  Container getStatBar(){
    return Container(
        margin: const EdgeInsets.all(10.0),
        child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                child: const Text(
                  "Name Value",
                  style: TextStyle(
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
                ranges: <LinearGaugeRange>[
                  LinearGaugeRange(
                    startValue: 0,
                    endValue: 2,
                    startWidth: 10,
                    endWidth: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.red[600]!, Colors.red, Colors.red[300]!, Colors.yellow],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                  LinearGaugeRange(
                    startValue: 2,
                    endValue: 4,
                    startWidth: 10,
                    endWidth: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.yellow, Colors.yellow[300]!],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                  LinearGaugeRange(
                    startValue: 4,
                    endValue: 6,
                    startWidth: 10,
                    endWidth: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.yellow[300]!, Colors.green[300]!, Colors.green, Colors.green[600]!],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                ],
                markerPointers: <LinearShapePointer>[
                  LinearShapePointer(
                    value: temperatureValue,
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
}

class SliderDialog extends StatefulWidget {
  const SliderDialog({super.key});

  @override
  State<SliderDialog> createState() => SliderDialogState();
}

class SliderDialogState extends State<SliderDialog> {
  double _sliderValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Threshold before alert'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            value: _sliderValue,
            min: 10,
            max: 80,
            onChanged: (double value) {
              setState(() {
                _sliderValue = value;
              });
            },
            divisions: 70, // Set the number of divisions for the slider
            label: '${_sliderValue.toInt()}%', // Display the value as a label
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: const Text('Exit'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: const Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
