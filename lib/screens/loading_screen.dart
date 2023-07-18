

import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  //
  // Future<void> getData(double lat , double long)async{
  //   String url="https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$kApiKey&units=metric";
  //   NetworkHelper networkHelper=NetworkHelper(url: url);
  //   networkHelper.getData(url);
  // }

// تشغل فنكشن getLocaton , مع التراي و الكاتش و اذامشي الموضوع هيحةلنس ع صفحة اللوكيشةن

  @override
  void initState() {
    getWeatherDATA();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        //خلال عملية جلب البوزيشن اعرضلي هاد لحد م يجي البوزيشن
        child: CircularProgressIndicator(),
      ),
    );
  }

  void getWeatherDATA() async {
    WeatherModel weatherInfo = WeatherModel();
    await weatherInfo
        .getCurrentLocationWeather(); //getCurrentLocationWeather();
    if (mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(
          weatherData: weatherInfo,
          city: weatherInfo.name,
        );
      }));
    }
  }
}
