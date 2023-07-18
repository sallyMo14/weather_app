import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/screens/search_screen.dart';
import '../services/weather.dart';
import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final WeatherModel weatherData;
  final String city;
  const LocationScreen({super.key, required this.weatherData, this.city = ""});
  const LocationScreen.viaCity(
      {super.key, required this.weatherData, required this.city});
  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  late double temp;
  late String cityName;
  late String description;
  late String icon;
  late String desc;
  WeatherModel model = WeatherModel();
  bool isLoaded = false;
  ImageProvider Assetimage = const AssetImage("images/location_background.jpg");
  ImageProvider? Networkimage ;//= AssetImage("images/location_background.jpg");
  @override
  void initState() {
    updateUI(widget.weatherData);

    super.initState();
  }

  void updateUI(WeatherModel weatherData) {
    temp = weatherData.temp;
    cityName = weatherData.name;
    description = weatherData.getMessage();
    icon = weatherData.getWeatherIcon();
    desc = weatherData.getWeatherDesc();
    Networkimage = NetworkImage('https://source.unsplash.com/random/?$desc');
    getImageProvider();
  }

  void getImageProvider() {
    Networkimage!.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (image, synchronousCall) {
          setState(() {
            isLoaded = true;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.weatherData.name);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                // image: AssetImage('images/location_background.jpg'),
                image: !isLoaded ? Assetimage : Networkimage!, //☃
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
              ),
            ),
            constraints: const BoxConstraints.expand(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0.7),
                    Colors.white.withOpacity(0.3)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  // color: Colors.white.withOpacity(0.0),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        await model.getCurrentLocationWeather();
                        updateUI(model);
                      },
                      child: const Icon(
                        Icons.near_me,
                        size: 34.0,
                        color: kSecondaryColor,
                      ),
                    ),
                    Text(
                      cityName,
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: kSecondaryColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const SearchScreen();
                            },
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.location_city,
                        size: 34.0,
                        color: kSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      icon,
                      style: kConditionTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          "${temp.toInt()}",
                          style: kTempTextStyle,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 10),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 7,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                                  // shape: BoxShape.circle,
                                  ),
                            ),
                            const Text(
                              'now',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontFamily: 'Spartan MB',
                                letterSpacing: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //  Padding(

              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding: const EdgeInsets.all(34),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: kMessageTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
