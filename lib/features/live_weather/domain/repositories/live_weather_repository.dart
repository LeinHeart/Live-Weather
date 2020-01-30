import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/live_weather.dart';

abstract class LiveWeatherRepository {
  Future<Either<Failure, LiveWeather>> getWeatherFromDeviceLocation(
      double lat, double lng);
  Future<Either<Failure, LiveWeather>> getWeatherFromSearchCity(String city);
}
