import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherappwithgetx/bindings/weather_binding.dart';
import 'package:weatherappwithgetx/views/weather_home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialBinding: WeatherBinding(),
      debugShowCheckedModeBanner: false,
      home: WeatherHomeView(),
    );
  }
}

