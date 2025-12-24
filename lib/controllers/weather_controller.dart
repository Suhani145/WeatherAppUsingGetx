import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherappwithgetx/models/weather_model.dart';
import 'package:weatherappwithgetx/services/location_sevice.dart';
import 'package:weatherappwithgetx/services/weather_service.dart';

class WeatherController extends GetxController {
  final isLoading = false.obs;
  final weatherData = Rxn<WeatherModel>();

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
      weatherData.value= await _weatherService.fetchWeather(
        position.latitude,
        position.longitude,
      );
    } catch (e) {
      debugPrint("Weather error : $e");
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
