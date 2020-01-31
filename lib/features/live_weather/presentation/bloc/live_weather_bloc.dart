import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_jojonomic_tech_test_kristopher_chayadi/core/error/failures.dart';
import 'package:weather_app_jojonomic_tech_test_kristopher_chayadi/features/live_weather/domain/usecases/get_weather_from_device_location.dart';
import 'package:weather_app_jojonomic_tech_test_kristopher_chayadi/features/live_weather/domain/usecases/get_weather_from_search_city.dart';

import './bloc.dart';

String SERVER_FAILURE_MESSAGE = 'Server Failure';
String CACHE_FAILURE_MESSAGE = 'CACHE Failure';

class LiveWeatherBloc extends Bloc<LiveWeatherEvent, LiveWeatherState> {
  final GetWeatherFromDeviceLocation getWeatherFromCurrentLocation;
  final GetWeatherFromSearchCity getWeatherFromSearchCity;

  LiveWeatherBloc({
    @required GetWeatherFromDeviceLocation loc,
    @required GetWeatherFromSearchCity city,
  })  : assert(loc != null),
        assert(city != null),
        getWeatherFromCurrentLocation = loc,
        getWeatherFromSearchCity = city;

  @override
  LiveWeatherState get initialState => LoadingLiveWeatherState();

  @override
  Stream<LiveWeatherState> mapEventToState(
    LiveWeatherEvent event,
  ) async* {
    if (event is GetLiveWeatherFromCurrentLocationEvent) {
      yield* _mapGetWeatherFromCurrentLocation(
          getWeatherFromCurrentLocation, event.lat, event.lng);
    } else if (event is GetLiveWeatherFromSearchCityEvent) {
      yield* _mapGetWeatherFromSearchCity(getWeatherFromSearchCity, event.city);
    }
  }

  Stream<LiveWeatherState> _mapGetWeatherFromCurrentLocation(
      GetWeatherFromDeviceLocation getWeather, double lat, double lng) async* {
    final failureOrLiveWeather = await getWeather(
        GetWeatherFromDeviceLocationParams(lat: lat, lng: lng));
    yield failureOrLiveWeather.fold((failure) {
      print('ERROR GetWeatherFromDeviceLocation || live_weather_bloc');
      return Error(error: _mapFailureToMessage(failure));
    }, (liveWeather) {
      print('GetWeatherFromDeviceLocation SUCCESS!!! || live_weather_bloc');
      return LoadedLiveWeatherState(liveWeather: liveWeather);
    });
  }

  Stream<LiveWeatherState> _mapGetWeatherFromSearchCity(
      GetWeatherFromSearchCity getWeather, String city) async* {
    final failureOrLiveWeather =
        await getWeather(GetWeatherFromSearchCityParams(city: city));
    yield failureOrLiveWeather.fold((failure) {
      return Error(error: _mapFailureToMessage(failure));
    }, (liveWeather) {
      return LoadedLiveWeatherState(liveWeather: liveWeather);
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.props[0].toString();
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected error';
    }
  }
}
