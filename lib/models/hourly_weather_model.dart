import 'package:flutter/material.dart';

class HourlyWeatherModel {
  String dtTxt;
  double hourlyTemp;
  String icon;

  HourlyWeatherModel({
    required this.dtTxt,
    required this.hourlyTemp,
    required this.icon,
  });

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherModel(
      dtTxt: json['dt_txt'] as String,
      hourlyTemp: (json['main']['temp'] as num).toDouble(),
      icon: json['weather'][0]['icon'] as String,
    );
  }
}

List<HourlyWeatherModel> hourlyWeatherList(Map<String, dynamic> json) {
  List<dynamic> parseList = json['list'] as List;
  return parseList
      .map((hourlyJson) => HourlyWeatherModel.fromJson(hourlyJson))
      .toList();
}
