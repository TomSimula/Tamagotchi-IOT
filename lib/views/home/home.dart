import 'package:flutter/material.dart';
import 'package:tamagotchi/modele/game.dart';
import 'package:tamagotchi/modele/settings.dart';
import 'package:tamagotchi/views/home/home_rename_dialog.dart';

import '../../modele/plant.dart';
import 'home_bottom_bar.dart';
import 'home_plant_value.dart';

class Home extends StatefulWidget {

  static Game currentGame = Game("My Plant", false, 1, Plant(100, 50, 50, 50), Settings(
      const RangeValues(25, 75), const RangeValues(25, 75),
      const RangeValues(25, 75)));

  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: PlantValue(
                updateGame: (gameInfo) {
                  setState(() {
                    Home.currentGame.updateGame(gameInfo);
                  });
                },
              )
          ),
          const Expanded(
              flex: 1,
              child: BottomBar()
          ),
        ],
      ),
    );
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

}