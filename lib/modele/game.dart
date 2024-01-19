import 'package:tamagotchi/modele/plant.dart';
import 'package:tamagotchi/modele/settings.dart';

class Game {
  String name;
  bool running;
  double speed;
  Plant plant;
  Settings settings;

  Game(this.name, this.running, this.speed, this.plant, this.settings);

  updateGame(Map gameInfo){
    running = gameInfo['game']['running'];
    speed = (gameInfo['game']['vitesse'] as int).toDouble();
    plant.updatePlant(gameInfo['plante']);
    settings.updateSettings(gameInfo['settings']);
  }

}