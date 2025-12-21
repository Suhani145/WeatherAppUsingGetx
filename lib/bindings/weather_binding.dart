
import 'package:get/get.dart';
import 'package:weatherappwithgetx/controllers/weather_controller.dart';

class WeatherBinding extends Bindings {
  @override
  void dependencies(){
    Get.lazyPut(() => WeatherController());
}
}