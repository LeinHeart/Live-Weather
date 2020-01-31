import 'package:equatable/equatable.dart';
import 'package:weather_app_jojonomic_tech_test_kristopher_chayadi/features/live_weather/domain/entities/live_weather.dart';
import 'package:meta/meta.dart';

abstract class LiveWeatherState extends Equatable {
  const LiveWeatherState();
}

class InitialLiveWeatherState extends LiveWeatherState {
  @override
  List<Object> get props => [];
}

class LoadingLiveWeatherState extends LiveWeatherState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LiveWeatherLoading';
}

class LoadedLiveWeatherState extends LiveWeatherState {
  final LiveWeather liveWeather;

  LoadedLiveWeatherState({@required this.liveWeather});

  @override
  List<Object> get props => [liveWeather];

  @override
  String toString() => 'LiveWeatherLoaded';
}

class Error extends LiveWeatherState {
  final String error;

  Error({@required this.error});

  @override
  List<Object> get props => [error];
}
