import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:weather_app_jojonomic_tech_test_kristopher_chayadi/core/location/user_location.dart';
import 'package:weather_app_jojonomic_tech_test_kristopher_chayadi/features/live_weather/data/models/weather_model.dart';
import 'package:weather_app_jojonomic_tech_test_kristopher_chayadi/features/live_weather/presentation/bloc/bloc.dart';

class Home extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserLocation _userLocation;
  int _weatherCode;

  //*[START Life Cycle]
  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }
  //*[END Life Cycle]

  //?[START Helper Method]
  Future<void> getCurrentLocation() async {
    var location = Location();
    try {
      var userLocation = await location.getLocation();
      setState(() {
        _userLocation = UserLocation(
          latitude: userLocation.latitude,
          longitude: userLocation.longitude,
        );
      });
    } on Exception catch (e) {
      print('Could not get location : ${e.toString()}');
    }
  }

  Future<Null> refresh(BuildContext context) async {
    getCurrentLocation();
    BlocProvider.of<LiveWeatherBloc>(context)
      ..add(
        GetLiveWeatherFromCurrentLocationEvent(
          lat: _userLocation.latitude,
          lng: _userLocation.longitude,
        ),
      );
  }
  //?[END Helper Method]

  //![START Build Method]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.blue,
          ),
          RefreshIndicator(
            onRefresh: () => refresh(context),
            child: Center(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: BlocBuilder<LiveWeatherBloc, LiveWeatherState>(
                  builder: (context, state) {
                    if (state is LoadingLiveWeatherState) {
                      return CircularProgressIndicator();
                    }
                    if (state is LoadedLiveWeatherState) {
                      var fm = DateFormat('EEE, d/M/y');
                      var fmHour = DateFormat('kk:mm');
                      WeatherModel model = state.liveWeather;

                      print('ini!!!');
                      print(_weatherCode);

                      if (model.coord.lat == 0 && model.coord.lat == 0) {
                        refresh(context);
                      }

                      return Center(
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(top: 100.0),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 200,
                                    height: 200,
                                    child: Image.network(
                                      'https://openweathermap.org/img/wn/${model.weather[0].icon}@2x.png',
                                      scale: 0.5,
                                    ),
                                  ),
                                  Text(
                                    model.name,
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    model.weather[0].description,
                                    style: TextStyle(
                                      fontSize: 30.0,
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  Text(
                                    '${model.main.temp} °C',
                                    style: TextStyle(
                                      fontSize: 50.0,
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  Text(
                                    fm.format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            model.dt * 1000)),
                                    style: TextStyle(
                                      fontSize: 30.0,
                                    ),
                                  ),
                                  Text(
                                    fmHour.format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            model.dt * 1000)),
                                    style: TextStyle(
                                      fontSize: 30.0,
                                    ),
                                  ),
                                  // Text(
                                  //   'Wind : ${model.wind.speed} / ${model.wind.deg}',
                                  //   style: TextStyle(
                                  //     fontSize: 20.0,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   'Pressure : ${model.main.pressure} hpa',
                                  //   style: TextStyle(
                                  //     fontSize: 20.0,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   'Humidity : ${model.main.humidity}%',
                                  //   style: TextStyle(
                                  //     fontSize: 20.0,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   'Sunrise : ${fmHour.format(DateTime.fromMillisecondsSinceEpoch(model.sys.sunrise * 1000))}',
                                  //   style: TextStyle(
                                  //     fontSize: 20.0,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   'Sunset : ${fmHour.format(DateTime.fromMillisecondsSinceEpoch(model.sys.sunset * 1000))}',
                                  //   style: TextStyle(
                                  //     fontSize: 20.0,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   'GeoCode : [${model.coord.lat} / ${model.coord.lon}]',
                                  //   style: TextStyle(
                                  //     fontSize: 20.0,
                                  //   ),
                                  // ),
                                  SizedBox(height: 100.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  //![END Build Method]

  //![START Extracted Widget]

  //![END Extracted Widget]

}
