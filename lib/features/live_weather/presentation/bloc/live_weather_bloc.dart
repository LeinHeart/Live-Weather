import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class LiveWeatherBloc extends Bloc<LiveWeatherEvent, LiveWeatherState> {
  @override
  LiveWeatherState get initialState => InitialLiveWeatherState();

  @override
  Stream<LiveWeatherState> mapEventToState(
    LiveWeatherEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
