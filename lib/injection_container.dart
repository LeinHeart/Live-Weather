import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/live_weather/data/datasources/live_weather_local_data_source.dart';
import 'features/live_weather/data/datasources/live_weather_remote_data_source.dart';
import 'features/live_weather/data/repositories/live_weather_repository_impl.dart';
import 'features/live_weather/domain/repositories/live_weather_repository.dart';
import 'features/live_weather/domain/usecases/get_weather_from_device_location.dart';
import 'features/live_weather/domain/usecases/get_weather_from_search_city.dart';
import 'features/live_weather/presentation/bloc/bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  registerLiveWeather();
  await registerCoreAndExternal();
  return null;
}

Future<void> registerCoreAndExternal() async {
  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
}

void registerLiveWeather() {
  //!Features - Live Weather
  //BLoC
  sl.registerFactory(
    () => LiveWeatherBloc(
      city: sl(),
      loc: sl(),
    ),
  );

  //UseCases
  sl.registerLazySingleton(() => GetWeatherFromDeviceLocation(sl()));
  sl.registerLazySingleton(() => GetWeatherFromSearchCity(sl()));

  //Repository
  sl.registerLazySingleton<LiveWeatherRepository>(
    () => LiveWeatherRepositoryImpl(
      networkInfo: sl(),
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );

  //Data Source
  sl.registerLazySingleton<LiveWeatherRemoteDataSource>(
      () => LiveWeatherRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<LiveWeatherLocalDataSource>(
      () => LiveWeatherLocalDataSourceImpl(sharedPreferences: sl()));
}
