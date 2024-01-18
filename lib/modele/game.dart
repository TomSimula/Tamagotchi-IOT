import 'package:tamagotchi/modele/plant.dart';
import 'package:tamagotchi/modele/settings.dart';

class Game {
  bool running;
  double speed;
  Plant plant;
  Settings settings;

  Game(this.running, this.speed, this.plant, this.settings);

  updateGame(Map gameInfo){
    running = gameInfo['game']['running'];
    speed = gameInfo['game']['vitesse'];
    plant.updatePlant(gameInfo['plante']);
    settings.updateSettings(gameInfo['settings']);
  }

}