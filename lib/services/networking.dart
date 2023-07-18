import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper{
  final String url;
  NetworkHelper({required this.url});

  Future<Map<String,dynamic>> getData()async{
    // String url="https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$kApiKey&units=metric";
    http.Response response =await http.get(Uri.parse(url));

    if(response.statusCode==200){
      print(response.body);
     return jsonDecode(response.body);
      // print(data['main']['temp']);
    }
    return Future.error("Something wrong");

  }
  Future<Map<String,dynamic>> getDataWithCityName(String city)async{
    // String url="https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$kApiKey&units=metric";
    http.Response response =await http.get(Uri.parse(url));

    if(response.statusCode==200){
      print(response.body);
     return jsonDecode(response.body);
      // print(data['main']['temp']);
    }
    return Future.error("Something wrong");

  }


  }