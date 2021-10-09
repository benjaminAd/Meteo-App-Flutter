import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meteo/Models/current_weather_model.dart';
import 'package:meteo/Requests/http_request.dart';
import 'package:meteo/cubit/city_name_cubit.dart';

class MeteoHomePage extends StatefulWidget {
  const MeteoHomePage({Key? key}) : super(key: key);

  @override
  _MeteoHomePageState createState() => _MeteoHomePageState();
}

class _MeteoHomePageState extends State<MeteoHomePage> {
  TextEditingController _controller = TextEditingController();
  final _myNetwork = new Network();
  CurrentWeatherModel old_data = new CurrentWeatherModel(
      new Coord(0, 0),
      [],
      "",
      new Main(0, 0, 0, 0, 0, 0),
      0,
      new Wind(0, 0),
      new Clouds(0),
      0,
      new Sys(0, 0, "", 0, 0),
      0,
      0,
      "",
      0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05),
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "nom de la ville",
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          context.read<CityNameCubit>().cityName =
                              _controller.text;
                          context.read<CityNameCubit>().emitCityName();
                        },
                        icon: FaIcon(FontAwesomeIcons.search),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: BlocBuilder<CityNameCubit, String>(
                  builder: (context, cityName) {
                    return FutureBuilder<CurrentWeatherModel>(
                        future: _myNetwork.getCurrentWeatherFromCityName(
                            cityName: cityName),
                        builder: (BuildContext context,
                            AsyncSnapshot<CurrentWeatherModel> snapshot) {
                          if (snapshot.hasData && old_data != snapshot.data) {
                            old_data = snapshot.data!;
                            var current_weather = snapshot.data!;
                            return Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${current_weather.name},${current_weather.sys.country}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.1,
                                    ),
                                  ),
                                  Text(new DateFormat('EEEE d MMMM y, H:mm')
                                      .format(DateTime.now())),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                  ),
                                  getWeatherIcon(
                                      weatherDescription:
                                          current_weather.weather.first.main,
                                      size: MediaQuery.of(context).size.width *
                                          0.5),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${convertFahrenheitToCelcius(current_weather.main.temp).toStringAsFixed(2)} C°",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                        ),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.thermometerHalf,
                                        color: Colors.red,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                      ),
                                      Text(
                                          "${current_weather.weather.first.description}"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            "${current_weather.wind.speed} m/s",
                                          ),
                                          Icon(FontAwesomeIcons.wind),
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(
                                            "${current_weather.main.humidity}%",
                                          ),
                                          Icon(FontAwesomeIcons.tint),
                                        ],
                                      )),
                                    ],
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                                  Text("Prévisions sur 7 jours"),

                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            print("Error ->" + snapshot.error.toString());
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 60,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Text('Error: ${snapshot.error}'),
                                  )
                                ],
                              ),
                            );
                          } else {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: CircularProgressIndicator(),
                                    width: 60,
                                    height: 60,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: Text("Récupération des données..."),
                                  )
                                ],
                              ),
                            );
                          }
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getWeatherIcon(
      {required String weatherDescription, required double size}) {
    print(weatherDescription);
    switch (weatherDescription) {
      case "Clear":
        {
          return Icon(FontAwesomeIcons.sun, color: Colors.orange, size: size);
        }
      case "Clouds":
        {
          print(FontAwesomeIcons.cloud.toString());
          return Icon(FontAwesomeIcons.cloud, color: Colors.blue, size: size);
        }
      case "Rain":
        {
          return Icon(FontAwesomeIcons.cloudRain,
              color: Colors.blue, size: size);
        }
      case "Snow":
        {
          return Icon(FontAwesomeIcons.snowman,
              color: Colors.white24, size: size);
        }
      default:
        {
          return Icon(FontAwesomeIcons.sun, color: Colors.orange, size: size);
        }
    }
  }

  double convertFahrenheitToCelcius(double us_temp) {
    return (us_temp - 273.15);
  }
}
