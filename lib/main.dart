import 'package:flutter/material.dart';
import 'package:tamagotchi/pages/home.dart';
import 'package:tamagotchi/pages/analytics.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/analytics': (context) => Analytics()
    },
  ));
}


