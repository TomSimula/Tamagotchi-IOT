import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tamagotchi/services/rest.dart';

import 'home.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => SettingsDialogState();
}

class SettingsDialogState extends State<SettingsDialog> {
  RangeValues waterRangeValue = RangeValues(Home.currentGame.settings.waterRangeValue.start, Home.currentGame.settings.waterRangeValue.end);
  RangeValues temperatureRangeValue = RangeValues(Home.currentGame.settings.temperatureRangeValue.start, Home.currentGame.settings.temperatureRangeValue.end);
  RangeValues lightRangeValue = RangeValues(Home.currentGame.settings.lightRangeValue.start, Home.currentGame.settings.lightRangeValue.end);
  double speed = Home.currentGame.speed;

  bool led = false;

  @override
  Widget build(BuildContext context) {
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
                    RestService().putLedSecond();
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
                      RestService().putLed();
                      setState(() {
                        led = value;
                      });
                    }
                )
            ]
          ),
          const SizedBox(height: 30),
          Column(
            children: [
              const Text('Game speed', style: TextStyle(fontSize: 20)),
              Slider(
                value: speed,
                onChanged: (value) {
                  setState(() {
                    speed = value;
                  });
                },
                min: 0,
                max: 5,
                divisions: 5,
                activeColor: const Color(0xFF65B741),
                label: speed.toInt().toString(),
              ),
            ],
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
                  // Convert the settings object to a Map
                  Map<String, dynamic> thresholdMap = {
                    'seuilLumiereBasse': lightRangeValue.start,
                    'seuilLumiereHaute': lightRangeValue.end,
                    'seuilTemperatureBasse': temperatureRangeValue.start,
                    'seuilTemperatureHaute': temperatureRangeValue.end,
                    'seuilEauBasse': waterRangeValue.start,
                    'seuilEauHaute': waterRangeValue.end,
                  };
                  Map<String, dynamic> speedMap = {
                    'vitesse': speed
                  };
                  // Encode the Map as a JSON string
                  String jsonBody = jsonEncode({'game': speedMap, 'settings': thresholdMap});
                  //Send update to TTGO
                  RestService().postSettings(jsonBody);
                  // Close the dialog
                  Navigator.pop(context);
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