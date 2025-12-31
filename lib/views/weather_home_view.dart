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

      body: Expanded(
        child: Obx(() {
          if (weatherController.isLoading.value) {
            return CircularProgressIndicator();
          }
          //current weather ui
          final currentWeather = weatherController.currentWeatherData.value;
          final hourlyData = weatherController.hourlyWeatherListData..take(8).toList();
          if (currentWeather == null ) {
            return Text("No Data found");
          }
          // && weatherController.hourlyWeatherListData.isEmpty
          return Column(
            children: [
              CurrentWeatherUI(screenWidth: screenWidth, screenHeight: screenHeight, currentWeather: currentWeather),
              HourlyWeatherUI(hourlyData: hourlyData, screenWidth: screenWidth, screenHeight: screenHeight)

            ],
          );
          //hourly card ui
        }),
      ),
    );
  }
}

class HourlyWeatherUI extends StatelessWidget {
  const HourlyWeatherUI({
    super.key,
    required this.hourlyData,
    required this.screenWidth,
    required this.screenHeight,
  });

  final RxList<HourlyWeatherModel> hourlyData;
  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hourlyData.length,
      itemBuilder: (context, index){
        final hour = hourlyData[index];
        return SizedBox(
          width: screenWidth * 0.9,
          height: screenHeight * 0.24,
          child: Card(
              elevation: 0,
              child: Column(
                children: [
                  Text(
                    _parseToTime(hour.dtTxt),
                    style: TextStyle(
                        fontSize: 8
                    ) ,
                  ),

                  SizedBox(height: 2),

                  Image.network("https://openweathermap.org/img/wn/${hour.icon}@2x.png",
                  width: 18,
                  height: 18,
                    fit: BoxFit.cover
                  ),
                  SizedBox(height: 2),
                  Text("${hour.hourlyTemp}",
                    style: TextStyle(
                        fontSize: 10
                    ) ,
                  ),

                ],
              )

          ),
        );
      },

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
      child: SizedBox(
        width: screenWidth * 0.75,
        height: screenHeight * 0.3,
        child: Card(
          elevation: 0,
          shadowColor: Colors.transparent,
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    ("${currentWeather!.temp} °C"),
                    style: TextStyle(fontSize: 40),
                  ),
                  SizedBox(width: 8),
                  Column(
                    children: [
                      SizedBox(height: 8),
                      Text(
                        ("H: ${currentWeather!.tempMax} °C"),
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Text(
                        ("L: ${currentWeather!.tempMin} °C"),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.location_pin),
                  SizedBox(height: 10),
                  Text(
                    currentWeather!.cityName,
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                ("${currentWeather!.feelsLike} °C"),
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _parseToTime(String dtTxt){
  DateTime dateTime = DateTime.parse(dtTxt);
  String formattedTime = DateFormat('HH:MM').format(dateTime);
  return formattedTime;

}
