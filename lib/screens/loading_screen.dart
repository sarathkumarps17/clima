import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import '../services/weather.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinkit/flutter_spinkit.dart';

WeatherModel weatherModel = WeatherModel();

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late Map weatherData;

  void getWeatherData() async {
    try {
      weatherData = await weatherModel.getLocationWeatherData();
      print(weatherData);
      Navigator.push(context, MaterialPageRoute(builder: (contest) {
        return LocationScreen(weatherData);
      }));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getWeatherData();
    return Scaffold(
      body: Center(
          child: SpinKitFadingCircle(
        color: Colors.blue,
        size: 100.0,
      )),
    );
  }
}
