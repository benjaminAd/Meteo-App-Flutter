import 'dart:convert';

import 'package:http/http.dart';
import 'package:meteo/Constants/constants.dart';
import 'package:meteo/Models/current_weather_model.dart';
import 'package:meteo/Models/seven_days_forecast_model.dart';

class Network {

  Future<CurrentWeatherModel> getCurrentWeatherFromCityName(
      {required String cityName}) async {
    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=${Constant.api_Key}";
    final response = await get(Uri.parse(url));
    print("URL : ${Uri.encodeFull(url)}");

    if (response.statusCode == 200) {
      print("weather Data : ${response.body}");
      return CurrentWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Erreur en essayant d'obtenir la météo actuelle de $cityName");
    }
  }

  Future<SevenDaysForecastModel> getSevenDaysForecastFromLongAndLat(
      {required double lon,
      required double lat,
      required String cityName}) async {
    var url =
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=hourly,minutely,alerts,current&appid=${Constant.api_Key}";
    final response = await get(Uri.parse(url));
    print("URL : ${Uri.encodeFull(url)}");

    if (response.statusCode == 200) {
      print("weather Data : ${response.body}");
      return SevenDaysForecastModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Erreur en essayant d'obtenir la météo actuelle de $cityName");
    }
  }
}
