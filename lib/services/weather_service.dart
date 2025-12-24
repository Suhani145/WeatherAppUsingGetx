import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherappwithgetx/models/weather_model.dart';

class WeatherService {
  final String API_KEY = "f36f7c3261ce5a1d118fdf2aa509e13a";

  Future<WeatherModel> fetchWeather(double lat, double lon) async{
    final String URL = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$API_KEY&units=metric";
    final response = await http.get(Uri.parse(URL));
    try{
      if(response.statusCode == 200){
        return WeatherModel.fromJson(jsonDecode(response.body));
      }else{
        throw Exception("Data not fetched");
      }
    }catch(e){
      throw Exception(e);
    }

}
}