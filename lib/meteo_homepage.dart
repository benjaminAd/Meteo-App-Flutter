import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meteo/Models/weather_model.dart';
import 'package:meteo/Requests/http_request.dart';
import 'package:meteo/cubit/weather_cubit.dart';

class MeteoHomePage extends StatefulWidget {
  const MeteoHomePage({Key? key}) : super(key: key);

  @override
  _MeteoHomePageState createState() => _MeteoHomePageState();
}

class _MeteoHomePageState extends State<MeteoHomePage> {
  TextEditingController _controller = TextEditingController();
  bool isResearchOn = false;

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
                          context.read<WeatherCubit>().setEmptyWeatherModel();
                          context
                              .read<WeatherCubit>()
                              .getWeatherModel(cityName: _controller.text);
                        },
                        icon: FaIcon(FontAwesomeIcons.search),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                        BlocBuilder<WeatherCubit, WeatherModel>(
                            builder: (context, weather_model) {
                              if (weather_model.cod == "") {
                                return CircularProgressIndicator();
                              }
                              return Card(
                                child: ListTile(
                                  title: Text(weather_model.city.name),
                                  subtitle: Text("Vitesse du vent : ${weather_model.list[0].wind.speed}"),
                                ),
                              );
                            },
                          )
                  ],
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
