import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import '../../../../core/location/user_location.dart';
import '../../data/models/weather_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserLocation _currentLocation;
  String error;

  //*[START Life Cycle]
  @override
  void initState() {
    _currentLocation = UserLocation(latitude: 0.0, longitude: 0.0);
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
        _currentLocation = UserLocation(
          latitude: userLocation.latitude,
          longitude: userLocation.longitude,
        );
      });

      print('INI!!!!');
      print(_currentLocation.latitude);
      print(_currentLocation.longitude);
    } on Exception catch (e) {
      print('Could not get location : ${e.toString()}');
    }
  }

  Future<WeatherModel> getWeather(String lat, String lng) async {
    final response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lng&APPID=5be878e19606f24075985f51200f217d&units=metric');
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      var model = WeatherModel.fromJson(result);
      return model;
    } else {
      throw Exception('Failed to load Weather Information');
    }
  }

  Future<Null> refresh() async {
    getCurrentLocation();
  }
  //?[END Helper Method]

  //! [START Build Method]
  @override
  Widget build(BuildContext context) {
    print('ITUUUUUUU!!!!!!!');
    print(_currentLocation.latitude);
    print(_currentLocation.longitude);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Live Weather',
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('LIVE WEATHER'),
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: RefreshIndicator(
            onRefresh: () => refresh(),
            child: Center(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: FutureBuilder<WeatherModel>(
                  future: getWeather(_currentLocation.latitude.toString(),
                      _currentLocation.longitude.toString()),
                  builder: (context, snapshot) {
                    if (_currentLocation.latitude == 0.0) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      WeatherModel model = snapshot.data;
                      var fm = DateFormat('EEE, d/M/y');
                      var fmHour = DateFormat('kk:mm');

                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Weather in',
                              style: TextStyle(
                                fontSize: 30.0,
                              ),
                            ),
                            Text(
                              model.name,
                              style: TextStyle(fontSize: 30.0),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.network(
                                    'https://openweathermap.org/img/wn/${model.weather[0].icon}@2x.png'),
                                Text(
                                  '${model.main.temp} °C',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              model.weather[0].description,
                              style: TextStyle(
                                fontSize: 30.0,
                              ),
                            ),
                            Text(
                              fm.format(DateTime.fromMillisecondsSinceEpoch(
                                  model.dt * 1000)),
                              style: TextStyle(
                                fontSize: 30.0,
                              ),
                            ),
                            Text(
                              fmHour.format(DateTime.fromMillisecondsSinceEpoch(
                                  model.dt * 1000)),
                              style: TextStyle(
                                fontSize: 30.0,
                              ),
                            ),
                            Text(
                              'Wind : ${model.wind.speed} / ${model.wind.deg}',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              'Pressure : ${model.main.pressure} hpa',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              'Humidity : ${model.main.humidity}%',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              'Sunrise : ${fmHour.format(DateTime.fromMillisecondsSinceEpoch(model.sys.sunrise * 1000))}',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              'Sunset : ${fmHour.format(DateTime.fromMillisecondsSinceEpoch(model.sys.sunset * 1000))}',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              'GeoCode : [${model.coord.lat} / ${model.coord.lon}]',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(height: 100.0),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        '${snapshot.error}',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.red,
                        ),
                      );
                    }
                    return CircularProgressIndicator(); //default show loading
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  //![END Builder Method]
}
