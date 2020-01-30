import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_jojonomic_tech_test_kristopher_chayadi/features/live_weather/data/models/weather_model.dart';

class LiveWeather extends Equatable {
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

  LiveWeather({
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

  @override
  List<Object> get props => [
        coord,
        weather,
        base,
        main,
        wind,
        clouds,
        dt,
        sys,
        timezone,
        id,
        name,
        cod,
      ];
}
