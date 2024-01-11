import 'package:flutter/material.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => SettingsDialogState();
}

class SettingsDialogState extends State<SettingsDialog> {
  RangeValues waterRangeValue = const RangeValues(20, 80);
  RangeValues temperatureRangeValue = const RangeValues(20, 80);
  RangeValues lightRangeValue = const RangeValues(20, 80);

  bool led = false;

  @override
  Widget build(BuildContext context) {
    //TODO recovers Threshold valus
    return AlertDialog(
      title: const Text('Settings', textAlign: TextAlign.center),
      backgroundColor: const Color(0xFF976b48),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 20),
          const Text('Ping', style: TextStyle(fontSize: 20)),
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
                    activeTrackColor: const Color(0xFFA3EE97),
                    inactiveThumbColor: const Color(0xFF65B741),
                    activeColor: const Color(0xFF65B741),
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        led = value;
                      });
                    }
                )
            ]
          ),
          const SizedBox(height: 30),
          Column(
            children: <Widget>[
              const Text('Threshold before alert', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              const Text('Water'),
              createRangeSlider(waterRangeValue, (values) {
                setState(() {
                  waterRangeValue = values; // Update the state variable
                });
              }),
              const SizedBox(height: 20),
              const Text('Temperature'),
              createRangeSlider(temperatureRangeValue, (values) {
                setState(() {
                  temperatureRangeValue = values; // Update the state variable
                });
              }),
              const SizedBox(height: 20),
              const Text('Light'),
              createRangeSlider(lightRangeValue, (values) {
                setState(() {
                  lightRangeValue = values; // Update the state variable
                });
              }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
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

  createRangeSlider(RangeValues rangeValue, Function(RangeValues) onChanged) {
    return RangeSlider(
      values: rangeValue,
      onChanged: (RangeValues values) {
        onChanged(values); // Call the provided callback to update the state
      },
      min: 0,
      max: 100,
      divisions: 100,
      activeColor: const Color(0xFF65B741),
      labels: RangeLabels(
        '${rangeValue.start.round()}%',
        '${rangeValue.end.round()}%',
      ),
    );
  }
}