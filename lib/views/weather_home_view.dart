import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherappwithgetx/controllers/weather_controller.dart';
import 'package:weatherappwithgetx/models/daily_weather_model.dart';
import 'package:weatherappwithgetx/views/weather_background.dart';
import 'current_weather_ui.dart';
import 'daily_weather_ui.dart';
import 'hourly_weather_ui.dart';

class WeatherHomeView extends StatelessWidget {
  WeatherHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final WeatherController weatherController = Get.find<WeatherController>();
    final dailyData = weatherController.dailyWeatherListData;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: Stack(
        children: [
          Image.asset(
            WeatherBackground.backGroundImage(
              weatherController.currentWeatherData.value?.condition ?? 'clear',
            ),
            width: double.infinity,
            height: double.infinity,
          ),
          Obx(() {
            if (weatherController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final currentWeather = weatherController.currentWeatherData.value;
            if (currentWeather == null) {
              return const Center(child: Text("No Data found"));
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  CurrentWeatherUI(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    currentWeather: currentWeather,
                  ),
                  SizedBox(height: 200),
                  SizedBox(
                    height: screenHeight * 0.28,
                    child: HourlyWeatherUI(
                      hourlyData: weatherController.hourlyWeatherListData,
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      //maxHeight: constraints.maxHeight * 0.12,
                      currentWeather: currentWeather,
                    ),
                  ),

                  SizedBox(height: 10),

                  DailyWeatherUI(
                    screenHeight: screenHeight,
                    dailyData: dailyData,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
