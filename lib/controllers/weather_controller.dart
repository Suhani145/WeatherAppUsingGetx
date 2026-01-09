import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherappwithgetx/models/current_weather_model.dart';
import 'package:weatherappwithgetx/models/hourly_weather_model.dart';
import 'package:weatherappwithgetx/services/location_sevice.dart';
import 'package:weatherappwithgetx/services/weather_service.dart';

import '../models/daily_weather_model.dart';

class WeatherController extends GetxController {
  final isLoading = false.obs;
  final currentWeatherData = Rxn<CurrentWeatherModel>();
  final hourlyWeatherListData = <HourlyWeatherModel>[].obs;
  //final hourlyWeatherListData = RxList<HourlyWeatherModel>();
  final dailyWeatherListData = <DailyWeatherModel>[].obs;

  final LocationService _locationService = LocationService();
  final WeatherService _weatherService = WeatherService();

  @override
  void onInit() {
    super.onInit();
    debugPrint("WeatherController initialized");
    loadData();
    //super.onInit();
  }

  Future<void> loadData() async {
    try {
      isLoading.value = true;
      final position = await _locationService.getCurrentPostion();
      currentWeatherData.value= await _weatherService.fetchCurrentWeather(
        position.latitude,
        position.longitude,
      );
      final hourlyData = await _weatherService.fetchHourlyWeather(
        position.latitude,
        position.longitude,
      );
      hourlyWeatherListData.assignAll(hourlyData);

      final dailyData = await _weatherService.fetchDailyWeather(
        position.latitude,
        position.longitude,
      );
      dailyWeatherListData.assignAll(dailyData);
      debugPrint("Daily Weather:  $dailyWeatherListData");

    } catch (e) {
      debugPrint("Weather error : $e");
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}

String parseToDay(String dtTxt) {
  DateTime dateTime = DateTime.parse(dtTxt);
  String formattedTime = DateFormat('EEE').format(dateTime);
  return formattedTime;
}
