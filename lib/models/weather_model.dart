
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class WeatherModel {

  final double temp;
  final String cityName;
  final double feelsLike;
  final double tempMax;
  final double tempMin;
  WeatherModel({
    required this.temp,
    required this.cityName,
    required this.feelsLike,
    required this.tempMax,
    required this.tempMin
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json){
    return WeatherModel(
    temp: (json['main']['temp'] as num).toDouble(),
    cityName: json['name'] as String,
    feelsLike: (json['main']['feels_like'] as num).toDouble(),
    tempMax: (json['main']['temp_max'] as num).toDouble(),
    tempMin: (json['main']['temp_min'] as num).toDouble(),
  );
  }
}