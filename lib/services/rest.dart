import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tamagotchi/modele/settings.dart';

class RestService{

  String ip = "192.168.173.175";

  Future<Map> getStateFlower() async {
    Uri url = Uri.parse('http://$ip:80/state');
    Response response = await get(url);
    Map data = jsonDecode(response.body);
    return data;
  }

  postSettings(String jsonBody) async {
    Uri url = Uri.parse('http://$ip:80/settings');
    Response response = await post(url, body: jsonBody, headers: {'Content-Type': 'application/json'});
  }

  getSensor() async {
    Uri url = Uri.parse('http://$ip:80/capteurs');
    Response response = await get(url);
    Map data = jsonDecode(response.body);
  }

  putLedSecond() {
    Uri url = Uri.parse('http://$ip:80/testLed?temps=1');
    put(url);
  }

  putLed() {
    Uri url = Uri.parse('http://$ip:80/led/green');
    put(url);
  }

  putRunning() async {
    Uri url = Uri.parse('http://$ip:80/pause');
    put(url);
  }

}