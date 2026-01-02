import 'package:flutter/material.dart';

import '../models/current_weather_model.dart';

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
      child: SizedBox(
        width: screenWidth * 0.7,
        height: screenHeight * 0.22,
        child: Card(
          margin: const EdgeInsets.all(16.0),
          elevation: 0,
          color: Colors.transparent,
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