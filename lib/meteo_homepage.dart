import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meteo/Models/weather_model.dart';
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
  WeatherModel old_data = new WeatherModel(
      "", 0, 0, [], new City(0, "", new Coord(0, 0), "", 0, 0, 0, 0));

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
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                child: BlocBuilder<CityNameCubit, String>(
                  builder: (context, cityName) {
                    return FutureBuilder<WeatherModel>(
                        future: _myNetwork.getWeatherFromCityName(
                            cityName: cityName),
                        builder: (BuildContext context,
                            AsyncSnapshot<WeatherModel> snapshot) {
                          if (snapshot.hasData && old_data != snapshot.data) {
                            old_data = snapshot.data!;
                            return Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(snapshot.data!.city.name),
                                  Text(snapshot.data!.city.timezone.toString())
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
                    /*if (weathermodel.cod == "") {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text("Récupération des données")
                        ],
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(weathermodel.city.name),
                        Text(weathermodel.city.timezone.toString())
                      ],
                    );*/
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*FutureBuilder<WeatherModel>(
future: new Network()
    .getWeatherFromCityName(cityName: cityName),
builder: (BuildContext context,
    AsyncSnapshot<WeatherModel> snapshot) {
List<Widget> children;
if (snapshot.hasData) {
children = <Widget>[
const Icon(
Icons.check_circle_outline,
color: Colors.green,
size: 60,
),
Padding(
padding: const EdgeInsets.only(top: 16),
child: Text('Result: ${snapshot.data}'),
)
];
} else if (snapshot.hasError) {
print("Error ->" + snapshot.error.toString());
children = <Widget>[
const Icon(
Icons.error_outline,
color: Colors.red,
size: 60,
),
Padding(
padding: const EdgeInsets.only(top: 16),
child: Text('Error: ${snapshot.error}'),
)
];
} else {
children = const <Widget>[
SizedBox(
child: CircularProgressIndicator(),
width: 60,
height: 60,
),
Padding(
padding: EdgeInsets.only(top: 16),
child: Text('Awaiting result...'),
)
];
}
return Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
children: children,
),
);
},
)*/
