import 'package:flutter/material.dart';

class Settings {
  RangeValues waterRangeValue;
  RangeValues temperatureRangeValue;
  RangeValues lightRangeValue;

  Settings(this.waterRangeValue, this.temperatureRangeValue, this.lightRangeValue);

  updateSettings(Map settingsInfo){
    waterRangeValue = RangeValues((settingsInfo['seuilEauBasse'] as int).toDouble(), (settingsInfo['seuilEauHaute']).toDouble());
    temperatureRangeValue = RangeValues((settingsInfo['seuilTemperatureBasse']).toDouble(), (settingsInfo['seuilTemperatureHaute']).toDouble());
    lightRangeValue = RangeValues((settingsInfo['seuilLumiereBasse']).toDouble(), (settingsInfo['seuilLumiereHaute']).toDouble());
  }

}