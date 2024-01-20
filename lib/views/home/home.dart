import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tamagotchi/modele/game.dart';
import 'package:tamagotchi/modele/settings.dart';
import 'package:tamagotchi/views/home/home_rename_dialog.dart';
import 'package:tamagotchi/views/home/home_settings_dialog.dart';
import 'package:tamagotchi/services/rest.dart';
import 'dart:async';
import 'package:visibility_detector/visibility_detector.dart';
import '../../modele/plant.dart';

class Home extends StatefulWidget {

  static Game currentGame = Game("My Plant", false, 1, Plant(100, 50, 50, 50), Settings(
      const RangeValues(25, 75), const RangeValues(25, 75),
      const RangeValues(25, 75)));

  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {

  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('plant_value_detector'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction == 0) {
          // Widget is not visible, stop the timer
          stopTimer();
          if (Home.currentGame.running) {
            RestService().putRunning();
            Home.currentGame.running = false;
          }
        } else {
          // Widget is visible, start or restart the timer
          startTimer();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Home.currentGame.name),
          leading: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showRenameDialog();
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.center,
                  child: const Image(
                      image: AssetImage('assets/MyPlantV2.png')
                  ),
                )
            ),
            Expanded(
                flex: 5,
                child: getPlantValue()
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
                                showSettingsDialog();
                              },
                              icon: const Icon(
                                Icons.settings,
                                size: 40,
                              )
                          ),
                          ElevatedButton(
                              onPressed: () {
                                RestService().putRunning();
                              },
                              child: Home.currentGame.running ? const Text("Pause") : const Text("Play")
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
      ),
    );
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 250), (Timer timer) async {
      Map gameInfo = await RestService().getStateFlower();
      // Update plant value
      setState(() {
        Home.currentGame.updateGame(gameInfo);
      });
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  showRenameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RenameDialog(
          onNameChanged: (newName) {
            setState(() {
              Home.currentGame.name = newName;
            });
          },
        );
      },
    );
  }

  Widget getPlantValue(){
    return Column(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: createLifeBar(Home.currentGame.plant.life)
        ),
        Expanded(
            flex: 1,
            child: createProgressBar(
                "Water",
                Home.currentGame.plant.water,
                [
                  [Colors.yellow[600]!, Colors.yellow, Colors.yellow[300]!, Colors.blue[300]!],
                  [Colors.blue[300]!, Colors.blue],
                  [Colors.blue, Colors.blue[900]!, Colors.indigo[900]!]
                ]
            )
        ),
        Expanded(
            flex: 1,
            child: createProgressBar(
                "Temperature",
                Home.currentGame.plant.temperature,
                [
                  [Colors.red[600]!, Colors.red[300]!, Colors.green[300]!],
                  [Colors.green[300]!, Colors.green, Colors.green[300]!],
                  [Colors.green[300]!, Colors.blue[300]!, Colors.blue[600]!]
                ]
            )
        ),
        Expanded(
            flex: 1,
            child: createProgressBar(
                "Light",
                Home.currentGame.plant.light,
                [
                  [Colors.black, Colors.grey[850]!, Colors.grey, Colors.yellow[200]!],
                  [Colors.yellow[200]!, Colors.yellow, Colors.yellow[200]!],
                  [Colors.yellow[200]!, Colors.yellow[100]!, Colors.white]
                ]
            )
        )
      ],
    );
  }

  Container createLifeBar(double lifeValue){
    return Container(
        margin: const EdgeInsets.all(13.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Life: ${lifeValue.toInt()}/100', // Display life percentage
              style: const TextStyle(fontSize: 20),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.brown, width: 3), // Brown border
                borderRadius: BorderRadius.circular(5), // Rounded corners

              ),
              child: LinearProgressIndicator(
                minHeight: 15,
                value: lifeValue/100, // Set the progress value
                backgroundColor: Colors.grey,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green), // Set the color of the progress bar
              ),
            ),
          ],
        )
    );
  }

  //Progress bar
  Container createProgressBar(String valueName, double value, List<List<Color>> fadeColors){
    BorderSide myBorderSide = const BorderSide(color: Colors.brown, width: 3);
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
                maximum: 100,
                //Bar's part
                ranges: <LinearGaugeRange>[
                  LinearGaugeRange(
                    startValue: 0,
                    endValue: 33,
                    startWidth: 15,
                    endWidth: 15,
                    //Create fade color
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: fadeColors[0],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        border: Border(
                            left: myBorderSide,
                            bottom: myBorderSide,
                            top: myBorderSide
                        ),
                      ),
                    ),
                  ),
                  LinearGaugeRange(
                    startValue: 33,
                    endValue: 64,
                    startWidth: 15,
                    endWidth: 15,
                    //Create fade color
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: fadeColors[1],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          border: Border(
                              bottom: myBorderSide,
                              top: myBorderSide
                          )
                      ),
                    ),
                  ),
                  LinearGaugeRange(
                    startValue: 64,
                    endValue: 100,
                    startWidth: 15,
                    endWidth: 15,
                    //Create fade color
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: fadeColors[2],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          border: Border(
                              right: myBorderSide,
                              bottom: myBorderSide,
                              top: myBorderSide
                          )
                      ),
                    ),
                  ),
                ],
                //Bar's marker
                markerPointers: <LinearShapePointer>[
                  LinearShapePointer(
                    value: value,
                    width: 10,
                    height: 20,
                    position: LinearElementPosition.outside,
                    shapeType: LinearShapePointerType.invertedTriangle,
                    color: Colors.black,
                  ),
                ],
              )
            ]
        )
    );
  }

  void showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SettingsDialog();
      },
    );
  }

}