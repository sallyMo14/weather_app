// هنا في Api خاص بيجيب الوصف و الايقونة و الحرارة و المدينة و الدولة .. افضل م انه نعرف دوال بتجيب الوصف و الايقونة و ممكن تستخدي الوصف عشان موضوع الصورة الراندوم
import 'package:weather_app/services/location.dart';

import '../utilities/constants.dart';
import 'networking.dart';

class WeatherModel {
  late double temp;
  late int weatherId;

  // final String description;
  late String name;


  // WeatherModel({required this.temp, required this.weatherId, required this.name, });

  Future<void> getCurrentLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    Map<String, dynamic> weatherInfo = await NetworkHelper(
      url:
      "https://api.openweathermap.org/data/2.5/weather?lat=${location
          .lat}&lon=${location.long}&appid=$kApiKey&units=metric",
    ).getData();
    temp = weatherInfo['main']['temp'];
    weatherId = weatherInfo['weather'][0]['id'];
    name = weatherInfo['name'];

  }
  Future<void> getWeatherViaCityName(String city) async {


    Map<String,dynamic> weatherInfo = await NetworkHelper(
      url:
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$kApiKey&units=metric",
    ).getData();
    temp=weatherInfo['main']['temp'];
    weatherId=weatherInfo['weather'][0]['id'];
    name=city;

  }

  String getWeatherIcon() {
    if (weatherId < 300) {
      return '🌩';
    } else if (weatherId < 400) {
      return '🌧';
    } else if (weatherId < 600) {
      return '☔️';
    } else if (weatherId< 700) {
      return '☃️';
    } else if (weatherId < 800) {
      return '🌫';
    } else if (weatherId == 800) {
      return '☀️';
    } else if (weatherId <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getWeatherDesc() {
    if (weatherId < 300) {
      return 'Ominous Sky';
    } else if (weatherId < 400) {
      return 'Darkening Day';
    } else if (weatherId < 600) {
      return 'Rainy Day';
    } else if (weatherId< 700) {
      return 'Snowy day';
    } else if (weatherId < 800) {
      return 'windy day';
    } else if (weatherId == 800) {
      return 'sunny day';
    } else if (weatherId <= 804) {
      return 'cludy day';
    } else {
      return name;
    }
  }

  String getMessage() {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
