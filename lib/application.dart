import 'package:flutter/material.dart';
import 'package:weatherappwithgetx/views/weather_home_view.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
    ),
    home: WeatherHomeView(),
    );
  }
}