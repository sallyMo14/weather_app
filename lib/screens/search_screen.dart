import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';

import '../services/weather.dart';
import '../utilities/constants.dart';
import 'location_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override


  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CountryStateCityPicker(
                  country: country,
                  state: state,
                  city: city,
                  dialogColor: Colors.grey.shade200,
                  textFieldDecoration: InputDecoration(
                      fillColor: Colors.blueGrey.shade100,
                      filled: true,
                      suffixIcon: const Icon(Icons.arrow_downward_rounded),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none))),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: null,
              ),
              TextButton(
                onPressed: () {
                  print("${country.text}, ${state.text}, ${city.text}");
                  getWeatherDATA();
                },
                child: const Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
              const SizedBox(height: 20),

              Text(country.text==""?"":"${country.text}, ${state.text}, ${city.text}")
            ],
          ),
        ),
      ),
    );



  }

  void getWeatherDATA() async {
    WeatherModel weatherInfo=WeatherModel();
    await weatherInfo.getWeatherViaCityName(city.text);
    if(mounted)//getCurrentLocationWeather();
        {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return  LocationScreen(
          weatherData: weatherInfo,
          city: city.text,
        );
      }));
    }
  }
}
