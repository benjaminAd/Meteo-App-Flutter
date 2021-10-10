import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meteo/Models/current_weather_model.dart';
import 'package:meteo/Models/seven_days_forecast_model.dart';
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
      new Rain(0, 0),
      0,
      new Sys(0, 0, "", 0, 0),
      0,
      0,
      "",
      0);

  SevenDaysForecastModel old_forecast =
      new SevenDaysForecastModel(0, 0, "", 0, []);

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
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(0xFF, 0x10, 0x10, 0x37),
                  Color.fromARGB(0xFF, 0x46, 0x45, 0x70),
                ]),
          ),
          height: MediaQuery.of(context).size.height * 1.1,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
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
                      icon: FaIcon(
                        FontAwesomeIcons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height:MediaQuery.of(context).size.height*0.05,
              ),
              BlocBuilder<CityNameCubit, String>(
                builder: (context, cityName) {
                  return FutureBuilder<CurrentWeatherModel>(
                      future: _myNetwork.getCurrentWeatherFromCityName(
                          cityName: cityName),
                      builder: (BuildContext context,
                          AsyncSnapshot<CurrentWeatherModel> snapshot) {
                        if (snapshot.hasData && old_data != snapshot.data) {
                          old_data = snapshot.data!;
                          var current_weather = snapshot.data!;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(0x79, 0x79, 0xA3, 0.3),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Today",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          new DateFormat('EE, d MMM')
                                              .format(DateTime.now()),
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${convertFahrenheitToCelcius(current_weather.main.temp).toStringAsFixed(0)}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.15,
                                                ),
                                              ),
                                              Text(
                                                "°C",
                                                style: TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.06,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: getWeatherIcon(
                                              weatherDescription:
                                                  current_weather
                                                      .weather.first.main,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Text(
                                              "${current_weather.wind.speed} m/s",
                                            ),
                                            Icon(
                                              FontAwesomeIcons.wind,
                                              color: Colors.blueGrey,
                                            ),
                                          ],
                                        )),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Text(
                                              "${current_weather.main.humidity}%",
                                            ),
                                            Icon(
                                              FontAwesomeIcons.tint,
                                              color: Colors.lightBlue,
                                            ),
                                          ],
                                        )),
                                        if (current_weather
                                                .weather.first.main ==
                                            "Rain")
                                          Expanded(
                                              child: Column(
                                            children: [
                                              Text(
                                                "${current_weather.rain.d1h} mm",
                                              ),
                                              Icon(
                                                FontAwesomeIcons.cloudRain,
                                                color: Colors.blueAccent,
                                              ),
                                            ],
                                          )),
                                        if (current_weather
                                                .weather.first.main ==
                                            "Rain")
                                          Expanded(
                                              child: Column(
                                            children: [
                                              Text(
                                                "${current_weather.rain.d3h} mm",
                                              ),
                                              Icon(
                                                FontAwesomeIcons.cloudRain,
                                                color: Colors.lightBlue,
                                              ),
                                            ],
                                          )),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.mapMarkerAlt,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "${current_weather.name},${current_weather.sys.country}",
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:MediaQuery.of(context).size.height*0.03,
                              ),
                              Text(
                                "Prévisions sur 7 jours",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height:MediaQuery.of(context).size.height*0.03,
                              ),
                              FutureBuilder<SevenDaysForecastModel>(
                                future: _myNetwork
                                    .getSevenDaysForecastFromLongAndLat(
                                        lon: current_weather.coord.lon,
                                        lat: current_weather.coord.lat,
                                        cityName: current_weather.name),
                                builder: (BuildContext context,
                                    AsyncSnapshot<SevenDaysForecastModel>
                                        snapshot) {
                                  if (snapshot.hasData &&
                                      old_forecast != snapshot.data!) {
                                    old_forecast = snapshot.data!;
                                    var actual_forecast = snapshot.data!;
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        bottom:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              actual_forecast.daily.length - 1,
                                          itemBuilder: (context, index) {
                                            var daily = actual_forecast
                                                .daily[index + 1];
                                            var today = DateTime.now();
                                            return Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color.fromRGBO(
                                                    0x79, 0x79, 0xA3, 0.3),
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.02),
                                              child: Container(
                                                color: Color.fromRGBO(
                                                    0x79, 0x79, 0xA3, 0.3),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      ListTile(
                                                        leading: getWeatherIcon(
                                                            weatherDescription:
                                                                daily.weather
                                                                    .first.main,
                                                            size: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.05),
                                                        title: Text(
                                                          new DateFormat('EEEE')
                                                              .format(DateTime(
                                                                  today.year,
                                                                  today.month,
                                                                  (today.day!! +
                                                                      (index +
                                                                          1)))),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "${convertFahrenheitToCelcius(daily.temp.min).toStringAsFixed(0)}°C",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Icon(FontAwesomeIcons
                                                              .thermometerHalf),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.01,
                                                          ),
                                                          Text(
                                                            "${convertFahrenheitToCelcius(daily.temp.max).toStringAsFixed(0)}°C",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Icon(FontAwesomeIcons
                                                              .thermometerFull),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.01,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "${daily.humidity}%",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.01,
                                                          ),
                                                          Icon(FontAwesomeIcons
                                                              .tint),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.01,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "${daily.windSpeed} m/s",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.01,
                                                          ),
                                                          Icon(FontAwesomeIcons
                                                              .wind),
                                                        ],
                                                      ),
                                                      if (daily.rain != 0.0)
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "${daily.rain} mm",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.01,
                                                            ),
                                                            Icon(
                                                                FontAwesomeIcons
                                                                    .cloudRain),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    );
                                  } else if (snapshot.hasError) {
                                    print(
                                        "Error ->" + snapshot.error.toString());
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                          size: 60,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16),
                                          child: Text(
                                            'Error: ${snapshot.error}',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  } else {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          child: CircularProgressIndicator(),
                                          width: 60,
                                          height: 60,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 16),
                                          child: Text(
                                            "Récupération des données...",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.0005,
                              ),
                            ],
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
                                  child: Text(
                                    'Error: ${snapshot.error}',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
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
                                  child: Text(
                                    "Récupération des données...",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      });
                },
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
