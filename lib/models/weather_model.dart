import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class WeatherModel {

  String temp;
  String cityName;
  String feelsLike;
  WeatherModel({
    required this.temp,
    required this.cityName,
    required this.feelsLike
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json){
    return WeatherModel(
    temp: json['main']['temp'],
    cityName: json['name'],
  feelsLike: json['main']['feels_like']
  );
  }
}