import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherappwithgetx/controllers/weather_controller.dart';

class WeatherHomeView extends StatelessWidget {
  WeatherHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = Get.find<WeatherController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Current Weather')),

      body: Center(
        child: Obx(
          (){
              if (weatherController.isLoading.value){
                return CircularProgressIndicator();
              }
                final weather = weatherController.weatherData.value;
                if(weather == null){
                  return Text("No Data found");
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(weather.cityName,
                        style: TextStyle(fontSize: 24)),
                    SizedBox(height: 8),
                    Text(weather.temp, style: TextStyle(fontSize: 40)),
                    SizedBox(height: 8),
                    Text(weather.feelsLike, style: TextStyle(fontSize: 18)),
                  ],
                );
          }
        ),
      ),
    );
  }
}
