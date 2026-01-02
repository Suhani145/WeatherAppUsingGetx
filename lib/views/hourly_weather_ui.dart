import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/current_weather_model.dart';
import '../models/hourly_weather_model.dart';

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
    if (hourlyData.isEmpty) {
      return const Center(child: Text("No Hourly Data found"));
    }

    return Container(
      height: maxHeight,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today's Feel like temperature: ${currentWeather!.feelsLike.toStringAsFixed(1)}°C",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 8),
            Text(
              'Hourly Forecast',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 1,),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: limitedData.length,
                itemBuilder: (context, index) {
                  final hour = limitedData[index];
                  return SizedBox(
                    width: screenWidth * 0.20,
                    //height: screenHeight * 0.20,

                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      elevation: 0,
                      //color: Colors.transparent,
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
                            //const SizedBox(height: 4),
                            Image.network(
                              "https://openweathermap.org/img/wn/${hour.icon}@2x.png",
                              width: 18,
                              height: 18,
                              fit: BoxFit.contain,
                            ),
                            //const SizedBox(height: 4),
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

String _parseToTime(String dtTxt) {
  DateTime dateTime = DateTime.parse(dtTxt);
  String formattedTime = DateFormat('HH:mm').format(dateTime);
  return formattedTime;
}