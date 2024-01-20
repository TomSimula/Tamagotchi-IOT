import 'package:flutter/material.dart';
import 'package:tamagotchi/services/rest.dart';
import 'package:tamagotchi/views/defeat/defeat.dart';
import 'package:tamagotchi/views/home/home.dart';
import 'package:tamagotchi/views/sensor/sensor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  //init firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Restart the game to have a new game
  RestService().postRestart();

  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: const Color(0xFFA3EE97),
      appBarTheme: const AppBarTheme(
        color: Color(0xFFFFC051)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF65B741),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      )
    ),
    initialRoute: '/defeat',
    routes: {
      '/': (context) => const Home(),
      '/analytics': (context) => const Sensor(),
      '/defeat': (context) => const Defeat()
    },
  ));
}


