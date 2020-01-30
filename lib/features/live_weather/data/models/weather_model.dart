import 'package:weather_app_jojonomic_tech_test_kristopher_chayadi/features/live_weather/domain/entities/live_weather.dart';
import 'package:meta/meta.dart';

class WeatherModel extends LiveWeather {
  Coord coord;
  List<Weather> weather;
  String base;
  Main main;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

  WeatherModel({
    @required this.coord,
    @required this.weather,
    @required this.base,
    @required this.main,
    @required this.wind,
    @required this.clouds,
    @required this.dt,
    @required this.sys,
    @required this.timezone,
    @required this.id,
    @required this.name,
    @required this.cod,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      coord: Coord.fromJson(json['coord']),
      weather: (json['weather'] as List)
          .map((item) => Weather.fromJson(item))
          .toList(),
      base: json['base'],
      main: Main.fromJson(json['main']),
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json['clouds']),
      dt: json['dt'],
      sys: Sys.fromJson(json['sys']),
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
      timezone: json['timezone'],
    );
  }
}

class Coord {
  double lon;
  double lat;

  Coord({this.lon, this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: double.parse(json['lon'].toString()),
      lat: double.parse(json['lat'].toString()),
    );
  }
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  double pressure;
  int humidity;
  double seaLevel;
  double grndLevel;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: double.parse(json['temp'].toString()),
      feelsLike: double.parse(json['feels_like'].toString()),
      tempMin: double.parse(json['temp_min'].toString()),
      tempMax: double.parse(json['temp_max'].toString()),
      pressure: double.parse(json['pressure'].toString()),
      humidity: json['humidity'],
      seaLevel: json['sea_level'] == null
          ? 0.0
          : double.parse(json['sea_level'].toString()),
      grndLevel: json['grnd_level'] == null
          ? 0.0
          : double.parse(json['grnd_level'].toString()),
    );
  }
}

class Wind {
  double speed;
  double deg;

  Wind({this.speed, this.deg});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: double.parse(json['speed'].toString()),
      deg: double.parse(json['deg'].toString()),
    );
  }
}

class Clouds {
  int all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }
}

class Sys {
  int sunrise;
  int sunset;

  Sys({this.sunrise, this.sunset});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}
