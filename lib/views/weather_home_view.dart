import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherappwithgetx/controllers/weather_controller.dart';

class WeatherHomeView extends StatelessWidget {
  WeatherHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final ScreenWidth = MediaQuery.sizeOf(context).width;
    final ScreenHeight = MediaQuery.sizeOf(context).height;
    final WeatherController weatherController = Get.find<WeatherController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Current Weather')),

      body: Expanded(
        child: Container(
          child: Obx(
            (){
                if (weatherController.isLoading.value){
                  return CircularProgressIndicator();
                }
                //current weather ui
                  final currentWeather = weatherController.currentWeatherData.value;
                  if(currentWeather == null){
                    return Text("No Data found");
                  }
                  return Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: ScreenWidth*0.75,
                      height: ScreenHeight*0.3,
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
                                Text(("${currentWeather.temp} °C"), style: TextStyle(fontSize: 40)),
                                SizedBox(width: 8),
                                Column(
                                  children: [
                                    SizedBox(height: 8),
                                    Text(("H: ${currentWeather.tempMax} °C"), style: TextStyle(fontSize: 18)),
                                    SizedBox(height: 8),
                                    Text(("L: ${currentWeather.tempMin} °C"), style: TextStyle(fontSize: 18)),
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
                                Text(currentWeather.cityName,
                                    style: TextStyle(fontSize: 24)),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(("${currentWeather.feelsLike} °C"), style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  );

                  //hourly card ui
            }
          ),
        ),
      ),
    );
  }
}
