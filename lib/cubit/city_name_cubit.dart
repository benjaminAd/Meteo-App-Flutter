import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:meteo/Models/weather_model.dart';
import 'package:meteo/Requests/http_request.dart';

class CityNameCubit extends Cubit<String> {
  String _cityName = "Paris";

  CityNameCubit() : super("Paris");

  set cityName(String value) {
    _cityName = value;
  }

  void emitCityName() {
    print(_cityName);
    emit(_cityName);
  }
}
