import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meteo/Models/weather_model.dart';
import 'package:meteo/Requests/http_request.dart';

class MeteoHomePage extends StatefulWidget {
  const MeteoHomePage({Key? key}) : super(key: key);

  @override
  _MeteoHomePageState createState() => _MeteoHomePageState();
}

class _MeteoHomePageState extends State<MeteoHomePage> {
  TextEditingController _controller = TextEditingController();
  String cityName = "";
  bool isResearchOn = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setResearchOn() {
    setState(() {
      if (_controller.text != null || _controller.text != "") {
        isResearchOn = true;
        cityName = _controller.text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
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
                          border: OutlineInputBorder(),
                          hintText: "nom de la ville",
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () => {_setResearchOn()},
                      icon: FaIcon(FontAwesomeIcons.search),
                    ),
                  ),
                ],
              ),
              (isResearchOn)
                  ? FutureBuilder<WeatherModel>(
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
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
