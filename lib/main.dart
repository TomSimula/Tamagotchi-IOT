import 'package:flutter/material.dart';
import 'package:tamagotchi/views/home/home.dart';
import 'package:tamagotchi/views/sensor/sensor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: const Color(0xFFA3EE97),
      appBarTheme: const AppBarTheme(
        color: Color(0xFFFFC051)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF65B741), // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Button border radius
          ),
        ),
      )
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => const Home(),
      '/analytics': (context) => const Sensor()
    },
  ));
}


