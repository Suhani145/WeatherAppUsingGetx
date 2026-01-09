import 'package:flutter/material.dart';

class DailyWeatherModel {
  String dt_txt;
  double temp_max;
  double temp_min;

  DailyWeatherModel({
    required this.dt_txt,
    required this.temp_max,
    required this.temp_min,
  });

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) {
    return DailyWeatherModel(
      dt_txt: json['dt_txt'] as String,
      temp_max: (json['main']['temp_max']! as num).toDouble(),
      temp_min: (json['main']['temp_min']! as num).toDouble(),
    );
  }
}

List<DailyWeatherModel> dailyWeatherList(Map<String, dynamic> json) {
  List<dynamic> parseList = json['list'] as List;
  Map<String, List<dynamic>> groupByDate = {};

  for (var item in parseList) {
    String date = item['dt_txt'].toString().split(' ')[0];
    if (!groupByDate.containsKey(date)) {
      groupByDate[date] = [];
    }
    groupByDate[date]!.add(item);
  }
  List<DailyWeatherModel> dailyWeather = [];
  groupByDate.forEach((date, items) {
    double tempMax = -double.infinity;
    double tempMin = double.infinity;
    for (var item in items) {
      double maxTemp = (item['main']['temp_max']! as num).toDouble();
      double minTemp = (item['main']['temp_min']! as num).toDouble();

      if (maxTemp > tempMax) {
        tempMax = maxTemp;
      }
      if (minTemp < tempMin) {
        tempMin = minTemp;
      }
    }
    dailyWeather.add(
      DailyWeatherModel(dt_txt: date, temp_max: tempMax, temp_min: tempMin),
    );
  });
  dailyWeather.sort((a, b) => a.dt_txt.compareTo(b.dt_txt));
  return dailyWeather.take(5).toList();
}
