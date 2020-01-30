import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/live_weather.dart';
import '../repositories/live_weather_repository.dart';

class GetWeatherFromSearchCity
    implements UseCase<LiveWeather, GetWeatherFromSearchCityParams> {
  final LiveWeatherRepository repository;

  GetWeatherFromSearchCity(this.repository);

  @override
  Future<Either<Failure, LiveWeather>> call(
      GetWeatherFromSearchCityParams params) async {
    return await repository.getWeatherFromSearchCity(params.city);
  }
}

class GetWeatherFromSearchCityParams extends Equatable {
  final String city;

  GetWeatherFromSearchCityParams({@required this.city});

  @override
  List<Object> get props => [city];
}
