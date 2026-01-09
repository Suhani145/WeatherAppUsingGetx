import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/daily_weather_model.dart';

class DailyWeatherUI extends StatelessWidget {
  const DailyWeatherUI({
    super.key,
    required this.screenHeight,
    required this.dailyData,
  });

  final double screenHeight;
  final RxList<DailyWeatherModel> dailyData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Text(
                'Tomorrow\'s temperature: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.25,
              child: ListView.builder(
                itemCount: dailyData.length,
                itemBuilder: (context, index) {
                  final daily = dailyData[index];
                  return SizedBox(
                    height: screenHeight * 0.08,
                    child: Card(
                      elevation: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(_parseToDay(daily.dt_txt)),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [Text("Max / "), Text("Min")],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("${daily.temp_max.toStringAsFixed(0)}°C / "),
                              Text("${daily.temp_min.toStringAsFixed(0)}°C"),
                            ],
                          ),
                        ],
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

String _parseToDay(String dtTxt) {
  DateTime dateTime = DateTime.parse(dtTxt);
  DateTime today = DateTime.now();
  bool isToday =
      dateTime.year == today.year &&
      dateTime.month == today.month &&
      dateTime.day == today.day;
  if (isToday) {
    return "Today";
  } else {
    String formattedTime = DateFormat('EEEE').format(dateTime);
    return formattedTime;
  }
}
