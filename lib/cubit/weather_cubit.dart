import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:meteo/Models/weather_model.dart';
import 'package:meteo/Requests/http_request.dart';

class WeatherCubit extends Cubit<WeatherModel> {
  final _network = new Network();

  WeatherCubit()
      : super(new WeatherModel(
            "", 0, 0, [], new City(0, "", new Coord(0, 0), "", 0, 0, 0, 0)));

  void getWeatherModel({required String cityName}) async =>
      emit(await _network.getWeatherFromCityName(cityName: cityName));

  void setEmptyWeatherModel() => emit(new WeatherModel(
      "", 0, 0, [], new City(0, "", new Coord(0, 0), "", 0, 0, 0, 0)));
}
