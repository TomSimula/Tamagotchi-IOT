import 'package:flutter/material.dart';
import 'package:tamagotchi/services/database.dart';
import 'package:tamagotchi/services/rest.dart';
import 'package:tamagotchi/views/home/home.dart';

import '../../modele/score.dart';

class Defeat extends StatelessWidget {

  const Defeat({super.key});

  @override
  Widget build(BuildContext context) {
    bool saved = false;
    return StreamBuilder(
      stream: DatabaseService().getScore(),
      builder: (context, snapshot) {
        if (!snapshot.hasData){
          return const CircularProgressIndicator();
        }
        List<Score> scores = snapshot.data as List<Score>;
        scores.sort((a, b) => b.score.compareTo(a.score));
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text("Your plant has died", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text('Your score : 500', style: TextStyle(fontSize: 20)),
              Expanded(
                child: ListView(
                  children: snapshot.data!.map((score) => Card( // display the note
                    child: ListTile(title: Text("${score.name}: ${score.score}"),),
                  )).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      //DatabaseService().postScore();
                      if (!saved) {
                        saved = true;
                        DatabaseService().addScore(Home.currentGame.name, 2000);
                      }
                    },
                    child: const Text('Save Score')
                  ),
                  ElevatedButton(
                      onPressed: () {
                        RestService().postRestart();
                        Navigator.pushNamed(context, '/');
                      },
                    child: const Text('Restart')
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}