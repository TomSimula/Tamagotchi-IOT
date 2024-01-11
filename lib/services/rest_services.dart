import 'dart:convert';
import 'package:http/http.dart';

class RestServices{

  static getStateFlower() async {
    Uri url = Uri.parse('http://192.168.4.1:80/state');
    Response response = await get(url);
    Map data = jsonDecode(response.body);
  }

  static getThresholdFlower() async {
    Uri url = Uri.parse('http://192.168.4.1:80/threshold');
    Response response = await get(url);
    Map data = jsonDecode(response.body);
  }

  static getSensorFlower() async {
    Uri url = Uri.parse('http://192.168.4.1:80/sensor');
    Response response = await get(url);
    Map data = jsonDecode(response.body);
  }

  static postLedSecond() async {
    Uri url = Uri.parse('http://192.168.4.1:80/sensor');
    Response response = await post(url);
  }

  static postLed(bool state) async {
    Uri url = Uri.parse('http://192.168.4.1:80/sensor');
    Response response = await post(url, body: {'state': state.toString()});
  }
}