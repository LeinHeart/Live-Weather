import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LiveWeatherEvent extends Equatable {
  const LiveWeatherEvent();
}

class GetLiveWeatherFromCurrentLocationEvent extends LiveWeatherEvent {
  final double lat;
  final double lng;

  GetLiveWeatherFromCurrentLocationEvent({
    @required this.lat,
    @required this.lng,
  });

  @override
  List<Object> get props => [lat, lng];
}

class GetLiveWeatherFromSearchCityEvent extends LiveWeatherEvent {
  final String city;

  GetLiveWeatherFromSearchCityEvent({@required this.city});

  @override
  List<Object> get props => [city];
}
