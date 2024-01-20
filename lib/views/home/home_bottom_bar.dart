import 'package:flutter/material.dart';

import '../../services/rest.dart';
import 'home.dart';
import 'home_settings_dialog.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
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