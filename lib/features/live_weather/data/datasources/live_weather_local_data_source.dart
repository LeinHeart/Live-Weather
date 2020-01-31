import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_jojonomic_tech_test_kristopher_chayadi/core/error/exceptions.dart';

import '../models/weather_model.dart';

abstract class LiveWeatherLocalDataSource {
  /// Get the cached [WeatherModel] which was gotten the last time
  /// the user had an internet connection
  ///
  /// Throws [NoLocalDataException] if no cached data is available
  Future<WeatherModel> getLastWeather();

  Future<void> cacheLiveWeather(WeatherModel liveWeatherToCache);
}

const CACHED_WEATHER = 'CACHED_WEATHER';

class LiveWeatherLocalDataSourceImpl implements LiveWeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  LiveWeatherLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<WeatherModel> getLastWeather() {
    final jsonString = sharedPreferences.getString(CACHED_WEATHER);
    if (jsonString != null) {
      return Future.value(WeatherModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheLiveWeather(WeatherModel liveWeatherToCache) {
    print('caching liveWeather to cache || live_weather_local_data_source');
    return sharedPreferences.setString(
      CACHED_WEATHER,
      json.encode(
        liveWeatherToCache.toJson(),
      ),
    );
  }
}
