import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherappwithgetx/controllers/weather_controller.dart';
import 'package:weatherappwithgetx/models/current_weather_model.dart';
import 'package:weatherappwithgetx/models/hourly_weather_model.dart';

class WeatherHomeView extends StatelessWidget {
  WeatherHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final WeatherController weatherController = Get.find<WeatherController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Current Weather')),
      body: Obx(() {
        if (weatherController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final currentWeather = weatherController.currentWeatherData.value;
        if (currentWeather == null &&
            weatherController.hourlyWeatherListData.isEmpty) {
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

                Expanded(
                  child: HourlyWeatherUI(
                    hourlyData: weatherController.hourlyWeatherListData,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    maxHeight: constraints.maxHeight * 0.22,
                    currentWeather: currentWeather,
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}

class HourlyWeatherUI extends StatelessWidget {
  const HourlyWeatherUI({
    super.key,
    required this.hourlyData,
    required this.screenWidth,
    required this.screenHeight,
    required this.maxHeight,
    required this.currentWeather,
  });

  final RxList<HourlyWeatherModel> hourlyData;
  final double screenWidth;
  final double screenHeight;
  final double maxHeight;
  final CurrentWeatherModel? currentWeather;

  @override
  Widget build(BuildContext context) {
    final limitedData = hourlyData.take(8).toList();

    return Container(
      height: maxHeight,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              " Today's Feel like temperature: ${currentWeather!.feelsLike.toStringAsFixed(1)}°C",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 8),
            Text(
              'Hourly Forecast',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: limitedData.length,
                itemBuilder: (context, index) {
                  final hour = limitedData[index];
                  return Container(
                    width: screenWidth * 0.20,
                    height: screenHeight * 0.20,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              _parseToTime(hour.dtTxt),
                              style: const TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Image.network(
                              "https://openweathermap.org/img/wn/${hour.icon}@2x.png",
                              width: 18,
                              height: 18,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${hour.hourlyTemp.toStringAsFixed(0)}°C",
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentWeatherUI extends StatelessWidget {
  const CurrentWeatherUI({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.currentWeather,
  });

  final double screenWidth;
  final double screenHeight;
  final CurrentWeatherModel? currentWeather;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: screenWidth * 0.70,
        height: screenHeight * 0.22,
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 0,
          shadowColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${currentWeather!.temp.toStringAsFixed(1)}°C",
                      style: const TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        Text(
                          "H: ${currentWeather!.tempMax.toStringAsFixed(1)}°C",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "L: ${currentWeather!.tempMin.toStringAsFixed(1)}°C",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 24),
                    const SizedBox(width: 6),
                    Text(
                      currentWeather!.cityName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _parseToTime(String dtTxt) {
  DateTime dateTime = DateTime.parse(dtTxt);
  String formattedTime = DateFormat('HH:mm').format(dateTime);
  return formattedTime;
}
