import 'dart:convert';

import 'package:http/http.dart';
import 'package:meteo/Constants/constants.dart';
import 'package:meteo/Models/current_weather_model.dart';
import 'package:meteo/Models/weather_model.dart';

class Network {
  Future<WeatherModel> getWeatherFromCityName(
      {required String cityName}) async {
    var url = "https://api.openweathermap.org/data/2.5/forecast?q=$cityName,fr&mode=json&appid=${Constant.api_Key}";
    final response = await get(Uri.parse(url));
    print("URL : ${Uri.encodeFull(url)}");

    if (response.statusCode == 200) {
      print("weather Data : ${response.body}");
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erreur en essayant d'obtenir la météo");
    }
  }

  Future<CurrentWeatherModel> getCurrentWeatherFromCityName({required String cityName}) async{
    var url = "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=${Constant.api_Key}";
    final response = await get(Uri.parse(url));
    print("URL : ${Uri.encodeFull(url)}");

    if (response.statusCode == 200) {
      print("weather Data : ${response.body}");
      return CurrentWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erreur en essayant d'obtenir la météo actuelle de $cityName");
    }
  }
}
