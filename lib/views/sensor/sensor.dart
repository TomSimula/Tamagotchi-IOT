import 'package:flutter/material.dart';
import 'package:tamagotchi/views/sensor/sensor_graph.dart';

class Sensor extends StatelessWidget {
  const Sensor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sensor"),
      ),
      body: ListView(
        children: const [
          Graph(),
          Graph(),
          Graph()
        ],
      )
    );
  }

  Widget description(){
    return const Column(
      children: [
        Text('SENSOR'),
      ],
    );
  }
}