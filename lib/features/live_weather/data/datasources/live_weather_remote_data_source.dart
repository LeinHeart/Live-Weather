import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../models/weather_model.dart';

abstract class LiveWeatherRemoteDataSource {
  /// Calls the 'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lng&APPID=5be878e19606f24075985f51200f217d&units=metric' endpoint
  ///
  /// Throw a [ServerExceptions] for all error codes
  Future<WeatherModel> getWeatherFromDeviceLocation(double lat, double lng);

  ///Caals the 'http://api.openweathermap.org/data/2.5/weather?q=$city&APPID=5be878e19606f24075985f51200f217d&units=metric'
  ///
  ///Throw a [ServerExceptions] for all error codes
  Future<WeatherModel> getWeatherFromSearchCity(String city);
}

class LiveWeatherRemoteDataSourceImpl implements LiveWeatherRemoteDataSource {
  final http.Client client;

  LiveWeatherRemoteDataSourceImpl({@required this.client});

  @override
  Future<WeatherModel> getWeatherFromDeviceLocation(
      double lat, double lng) async {
    final response = await client.get(
        'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lng&APPID=5be878e19606f24075985f51200f217d&units=metric');

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<WeatherModel> getWeatherFromSearchCity(String city) async {
    final response = await client.get(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&APPID=5be878e19606f24075985f51200f217d&units=metric');

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
