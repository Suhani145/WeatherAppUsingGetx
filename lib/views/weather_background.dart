class WeatherBackground {
  static String backGroundImage(String mainCondition) {
    DateTime now = DateTime.now();
    int hour = now.hour;
    String imageBasedOnTime = timeBasedImage(hour);
    return conditionBasedImage(mainCondition.toLowerCase(), imageBasedOnTime);
  }

  static String timeBasedImage(int hour) {
    bool isMorning = hour >= 6 && hour <= 16;
    bool isEvening = hour >= 17 && hour <= 19;
    // bool isNight = hour >= 20 || hour <=5;
    if (isMorning) {
      return "assets/images/morning.png";
    } else if (isEvening) {
      return "assets/images/evening.png";
    } else {
      return "assets/images/night.png";
    }
  }

  static String conditionBasedImage(String condition, String imageBasedOnTime) {
    switch (condition) {
      case 'rainy':
        return "assets/images/rainy.png";
      case 'snow':
        return "assets/images/snowy.png";
      case 'clear':
        return imageBasedOnTime;
      default:
        return imageBasedOnTime;
    }
  }
}
