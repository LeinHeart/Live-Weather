import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_jojonomic_tech_test_kristopher_chayadi/core/error/exceptions.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/live_weather.dart';
import '../../domain/repositories/live_weather_repository.dart';
import '../datasources/live_weather_local_data_source.dart';
import '../datasources/live_weather_remote_data_source.dart';

class LiveWeatherRepositoryImpl implements LiveWeatherRepository {
  final LiveWeatherRemoteDataSource remoteDataSource;
  final LiveWeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LiveWeatherRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, LiveWeather>> getWeatherFromDeviceLocation(
      double lat, double lng) async {
    if (await networkInfo.isConnected) {
      print('networkInfo isConnected || live_weather_repository_impl');
      try {
        print('awaiting remoteDataSource || live_weather_repository');
        final remoteLiveWeather =
            await remoteDataSource.getWeatherFromDeviceLocation(lat, lng);
        print('Caching LiveWeather || live_weather_repository');
        // localDataSource.cacheLiveWeather(remoteLiveWeather);
        print('returning Right || live_weather_repository');
        return Right(remoteLiveWeather);
      } on ServerException {
        return Left(
          ServerFailure(
              message:
                  'Something happen with the Server || error on live_weather_repository_impl'),
        );
      }
    } else {
      try {
        final localWeather = await localDataSource.getLastWeather();
        Right(localWeather);
      } on CacheException {
        return Left(
          CacheFailure(
              message:
                  'Something wrong with the Local data || error on live_weather_repository_impl'),
        );
      }
    }
  }

  @override
  Future<Either<Failure, LiveWeather>> getWeatherFromSearchCity(
      String city) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLiveWeather =
            await remoteDataSource.getWeatherFromSearchCity(city);
        return Right(remoteLiveWeather);
      } on ServerException {
        return Left(
          ServerFailure(
              message:
                  'Something happen with the Server || error on live_weather_repository_impl'),
        );
      }
    }
  }
}
