import 'dart:convert';

import 'package:http/http.dart';
import 'package:meteo/Constants/constants.dart';
import 'package:meteo/Models/weather_model.dart';

class Network {
  Future<WeatherModel> getWeatherFromCityName(
      {required String cityName}) async {
    var url =
        "api.openweathermap.org/data/2.5/forecast?q=$cityName,us&mode=xml&appid=${Constant.api_Key}";
    final response = await get(Uri.parse(url));
    print("URL : ${Uri.encodeFull(url)}");

    if (response.statusCode == 200) {
      print("weather Data : ${response.body}");
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erreur en essayant d'obtenir la météo");
    }
  }
}
