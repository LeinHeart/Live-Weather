import 'package:equatable/equatable.dart';

abstract class LiveWeatherState extends Equatable {
  const LiveWeatherState();
}

class InitialLiveWeatherState extends LiveWeatherState {
  @override
  List<Object> get props => [];
}
