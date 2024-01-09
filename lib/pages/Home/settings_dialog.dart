import 'package:flutter/material.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => SettingsDialogState();
}

class SettingsDialogState extends State<SettingsDialog> {
  double _sliderValue = 50.0;
  bool led = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: const Text('Settings', textAlign: TextAlign.center),
      backgroundColor: const Color(0xFFFBF6EE),
      content: Column(
        //TODO add space between settings
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              const Text('Ping', textAlign: TextAlign.left),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          //TODO
                          setState(() {
                            led = false;
                          });
                        },
                        child:const Text('LED')
                    ),
                    Switch(
                        value: led,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            led = value;
                          });
                        }
                    )
                  ]
              )
            ]
          ),
          Column(
            children: <Widget>[
              const Text('Threshold before alert', textAlign: TextAlign.left),
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
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  //TODO
                  Navigator.pop(context); // Close the dialog
                },
                child: const Text('Exit')
              ),
              ElevatedButton(
                onPressed: () {
                  //TODO
                  Navigator.pop(context); // Close the dialog
                },
                child: const Text('Apply')
              ),
            ],
          ),
        ],
      ),
    );
  }
}