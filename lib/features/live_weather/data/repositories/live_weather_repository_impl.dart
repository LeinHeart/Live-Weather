import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/live_weather.dart';
import '../../domain/repositories/live_weather_repository.dart';

class LiveWeatherRepositoryImpl implements LiveWeatherRepository {
  @override
  Future<Either<Failure, LiveWeather>> getWeatherFromDeviceLocation(
      double lat, double lng) {
    // TODO: implement getWeatherFromDeviceLocation
    return null;
  }

  @override
  Future<Either<Failure, LiveWeather>> getWeatherFromSearchCity(String city) {
    // TODO: implement getWeatherFromSearchCity
    return null;
  }
}
