import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_jojonomic_tech_test_kristopher_chayadi/features/live_weather/presentation/bloc/bloc.dart';
import 'package:weather_app_jojonomic_tech_test_kristopher_chayadi/features/live_weather/presentation/pages/home.dart';

import 'injection_container.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LiveWeatherBloc>(
          create: (_) => sl<LiveWeatherBloc>()
            ..add(GetLiveWeatherFromCurrentLocationEvent(lat: 0.0, lng: 0.0)),
        ),
      ],
      child: MaterialApp(
        title: 'Live Weather',
        initialRoute: Home.id,
        theme: ThemeData.light(),
        routes: {
          Home.id: (context) => Home(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
