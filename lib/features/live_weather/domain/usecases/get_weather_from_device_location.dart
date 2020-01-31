import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/live_weather.dart';
import '../repositories/live_weather_repository.dart';

class GetWeatherFromDeviceLocation
    implements UseCase<LiveWeather, GetWeatherFromDeviceLocationParams> {
  final LiveWeatherRepository repository;

  GetWeatherFromDeviceLocation(this.repository);

  @override
  Future<Either<Failure, LiveWeather>> call(
      GetWeatherFromDeviceLocationParams params) async {
    print(
        'awaiting getWeatherFromDeviceLocation Repository || get_weather_from_device_location');
    return await repository.getWeatherFromDeviceLocation(
        params.lat, params.lng);
  }
}

class GetWeatherFromDeviceLocationParams extends Equatable {
  final double lat;
  final double lng;

  GetWeatherFromDeviceLocationParams({
    @required this.lat,
    @required this.lng,
  });

  @override
  List<Object> get props => [lat, lng];
}
