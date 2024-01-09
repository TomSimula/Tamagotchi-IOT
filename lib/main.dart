import 'package:flutter/material.dart';
import 'package:tamagotchi/pages/Home/home.dart';
import 'package:tamagotchi/pages/analytics.dart';

void main() {
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
      '/analytics': (context) => const Analytics()
    },
  ));
}


