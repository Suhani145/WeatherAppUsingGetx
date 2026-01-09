import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherappwithgetx/controllers/weather_controller.dart';
import 'current_weather_ui.dart';
import 'hourly_weather_ui.dart';

class WeatherHomeView extends StatelessWidget {
  WeatherHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final WeatherController weatherController = Get.find<WeatherController>();


    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
          backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Image.asset("assets/images/morning.png",
          width: double.infinity,
          height: double.infinity,),
          Obx(() {
            if (weatherController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final currentWeather = weatherController.currentWeatherData.value;
            if (currentWeather == null) {
              return const Center(child: Text("No Data found"));
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    CurrentWeatherUI(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      currentWeather: currentWeather,
                    ),
                    SizedBox(height: 200),
                    Expanded(
                      child: HourlyWeatherUI(
                        hourlyData: weatherController.hourlyWeatherListData,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        maxHeight: constraints.maxHeight * 0.12,
                        currentWeather: currentWeather,
                      ),
                    ),

                    SizedBox(height: 100),
                    Center(
                      child: Text(
                        'Tomorrow\'s temperature: ',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              },
            );
          }),
        ],
      ),
    );
  }
}






