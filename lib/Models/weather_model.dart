import 'dart:core';

class WeatherModel {
  late String _cod;
  late int _message;
  late int _cnt;
  late List<WeatherList> _list;
  late City _city;

  WeatherModel(this._cod, this._message, this._cnt, this._list, this._city);

  String get cod => _cod;

  set cod(String cod) => _cod = cod;

  int get message => _message;

  set message(int message) => _message = message;

  int get cnt => _cnt;

  set cnt(int cnt) => _cnt = cnt;

  List<WeatherList> get list => _list;

  set list(List<WeatherList> value) => _list = value;

  City get city => _city;

  set city(City city) => _city = city;

  WeatherModel.fromJson(Map<String, dynamic> json) {
    _cod = json['cod'];
    _message = json['message'];
    _cnt = json['cnt'];
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list.add(new WeatherList.fromJson(v));
      });
    }
    _city = (json['city'] != null ? new City.fromJson(json['city']) : new City(0,"nia", new Coord(0.0, 0.0),"Country",0,9,0,0));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cod'] = this._cod;
    data['message'] = this._message;
    data['cnt'] = this._cnt;
    if (this._list != null) {
      data['list'] = this._list.map((v) => v.toJson()).toList();
    }
    if (this._city != null) {
      data['city'] = this._city.toJson();
    }
    return data;
  }
}

class WeatherList {
  late int _dt;
  late Main _main;
  late List<Weather> _weather;
  late Clouds _clouds;
  late Wind _wind;
  late int _visibility;
  late Sys _sys;
  late String _dtTxt;
  late Rain _rain;

  WeatherList(this._dt, this._main, this._weather, this._clouds, this._wind,
      this._visibility, this._sys, this._dtTxt, this._rain);

  int get dt => _dt;

  set dt(int dt) => _dt = dt;

  Main get main => _main;

  set main(Main main) => _main = main;

  List<Weather> get weather => _weather;

  set weather(List<Weather> weather) => _weather = weather;

  Clouds get clouds => _clouds;

  set clouds(Clouds clouds) => _clouds = clouds;

  Wind get wind => _wind;

  set wind(Wind wind) => _wind = wind;

  int get visibility => _visibility;

  set visibility(int visibility) => _visibility = visibility;

  Sys get sys => _sys;

  set sys(Sys sys) => _sys = sys;

  String get dtTxt => _dtTxt;

  set dtTxt(String dtTxt) => _dtTxt = dtTxt;

  Rain get rain => _rain;

  set rain(Rain rain) => _rain = rain;

  WeatherList.fromJson(Map<String, dynamic> json) {
    _dt = json['dt'];
    _main = (json['main'] != null ? new Main.fromJson(json['main']) : new Main(0,0,0,0,0,0,0));
    if (json['weather'] != null) {
      _weather = [];
      json['weather'].forEach((v) {
        _weather.add(new Weather.fromJson(v));
      });
    }
    _clouds =
        (json['clouds'] != null ? new Clouds.fromJson(json['clouds']) : new Clouds(0));
    _wind = (json['wind'] != null ? new Wind.fromJson(json['wind']) : new Wind(0, 0));
    _visibility = json['visibility'];
    _sys = (json['sys'] != null ? new Sys.fromJson(json['sys']) : new Sys(""));
    _dtTxt = json['dt_txt'];
    _rain = (json['rain'] != null ? new Rain.fromJson(json['rain']) : new Rain(0));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this._dt;
    if (this._main != null) {
      data['main'] = this._main.toJson();
    }
    if (this._weather != null) {
      data['weather'] = this._weather.map((v) => v.toJson()).toList();
    }
    if (this._clouds != null) {
      data['clouds'] = this._clouds.toJson();
    }
    if (this._wind != null) {
      data['wind'] = this._wind.toJson();
    }
    data['visibility'] = this._visibility;
    if (this._sys != null) {
      data['sys'] = this._sys.toJson();
    }
    data['dt_txt'] = this._dtTxt;
    if (this._rain != null) {
      data['rain'] = this._rain.toJson();
    }
    return data;
  }
}

class Main {
  late double _temp;
  late double _tempMin;
  late double _tempMax;
  late int _pressure;
  late int _seaLevel;
  late int _grndLevel;
  late int _humidity;

  Main(
      this._temp,
      this._tempMin,
      this._tempMax,
      this._pressure,
      this._seaLevel,
      this._grndLevel,
      this._humidity);

  double get temp => _temp;

  set temp(double temp) => _temp = temp;

  double get tempMin => _tempMin;

  set tempMin(double tempMin) => _tempMin = tempMin;

  double get tempMax => _tempMax;

  set tempMax(double tempMax) => _tempMax = tempMax;

  int get pressure => _pressure;

  set pressure(int pressure) => _pressure = pressure;

  int get seaLevel => _seaLevel;

  set seaLevel(int seaLevel) => _seaLevel = seaLevel;

  int get grndLevel => _grndLevel;

  set grndLevel(int grndLevel) => _grndLevel = grndLevel;

  int get humidity => _humidity;

  set humidity(int humidity) => _humidity = humidity;

  Main.fromJson(Map<String, dynamic> json) {
    _temp = json['temp'].toDouble();
    _tempMin = json['temp_min'].toDouble();
    _tempMax = json['temp_max'].toDouble();
    _pressure = json['pressure'];
    _seaLevel = json['sea_level'];
    _grndLevel = json['grnd_level'];
    _humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this._temp;
    data['temp_min'] = this._tempMin;
    data['temp_max'] = this._tempMax;
    data['pressure'] = this._pressure;
    data['sea_level'] = this._seaLevel;
    data['grnd_level'] = this._grndLevel;
    data['humidity'] = this._humidity;
    return data;
  }
}

class Weather {
  late int _id;
  late String _main;
  late String _description;
  late String _icon;

  Weather(this._id, this._main, this._description, this._icon);

  int get id => _id;

  set id(int id) => _id = id;

  String get main => _main;

  set main(String main) => _main = main;

  String get description => _description;

  set description(String description) => _description = description;

  String get icon => _icon;

  set icon(String icon) => _icon = icon;

  Weather.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _main = json['main'];
    _description = json['description'];
    _icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['main'] = this._main;
    data['description'] = this._description;
    data['icon'] = this._icon;
    return data;
  }
}

class Clouds {
  late int _all;

  Clouds(this._all);

  int get all => _all;

  set all(int all) => _all = all;

  Clouds.fromJson(Map<String, dynamic> json) {
    _all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this._all;
    return data;
  }
}

class Wind {
  late double _speed;
  late int _deg;

  Wind(this._speed, this._deg);

  double get speed => _speed;

  set speed(double speed) => _speed = speed;

  int get deg => _deg;

  set deg(int deg) => _deg = deg;

  Wind.fromJson(Map<String, dynamic> json) {
    _speed = json['speed'].toDouble();
    _deg = json['deg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = this._speed;
    data['deg'] = this._deg;
    return data;
  }
}

class Sys {
  late String _pod;

  Sys(this._pod);

  String get pod => _pod;

  set pod(String pod) => _pod = pod;

  Sys.fromJson(Map<String, dynamic> json) {
    _pod = json['pod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pod'] = this._pod;
    return data;
  }
}

class Rain {
  late double _d3h;

  Rain(this._d3h);

  double get d3h => _d3h;

  set d3h(double d3h) => _d3h = d3h;

  Rain.fromJson(Map<String, dynamic> json) {
    _d3h = json['3h'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['3h'] = this._d3h;
    return data;
  }
}

class City {
  late int _id;
  late String _name;
  late Coord _coord;
  late String _country;
  late int _population;
  late int _timezone;
  late int _sunrise;
  late int _sunset;

  City(this._id, this._name, this._coord, this._country, this._population,
      this._timezone, this._sunrise, this._sunset);

  int get id => _id;

  set id(int id) => _id = id;

  String get name => _name;

  set name(String name) => _name = name;

  Coord get coord => _coord;

  set coord(Coord coord) => _coord = coord;

  String get country => _country;

  set country(String country) => _country = country;

  int get population => _population;

  set population(int population) => _population = population;

  int get timezone => _timezone;

  set timezone(int timezone) => _timezone = timezone;

  int get sunrise => _sunrise;

  set sunrise(int sunrise) => _sunrise = sunrise;

  int get sunset => _sunset;

  set sunset(int sunset) => _sunset = sunset;

  City.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _coord =
        (json['coord'] != null ? new Coord.fromJson(json['coord']) : new Coord(0,0));
    _country = json['country'];
    _population = json['population'];
    _timezone = json['timezone'];
    _sunrise = json['sunrise'];
    _sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    if (this._coord != null) {
      data['coord'] = this._coord.toJson();
    }
    data['country'] = this._country;
    data['population'] = this._population;
    data['timezone'] = this._timezone;
    data['sunrise'] = this._sunrise;
    data['sunset'] = this._sunset;
    return data;
  }
}

class Coord {
  late double _lat;
  late double _lon;

  Coord(this._lat, this._lon);

  double get lat => _lat;

  set lat(double lat) => _lat = lat;

  double get lon => _lon;

  set lon(double lon) => _lon = lon;

  Coord.fromJson(Map<String, dynamic> json) {
    _lat = json['lat'].toDouble();
    _lon = json['lon'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this._lat;
    data['lon'] = this._lon;
    return data;
  }
}
