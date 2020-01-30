import '../models/weather_model.dart';

abstract class LiveWeatherRemoteDataSource {
  Future<WeatherModel> getWeatherFromDeviceLocation(double lat, double lng);
  Future<WeatherModel> getWeatherFromSearchCity(String city);
}
