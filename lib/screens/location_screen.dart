import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import '../services/weather.dart';
import 'city_screen.dart';

enum CallType { locationData, cityData }

class LocationScreen extends StatefulWidget {
  final Map weatherData;
  LocationScreen(this.weatherData);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

WeatherModel weatherModal = WeatherModel();

class _LocationScreenState extends State<LocationScreen> {
  late String weatherDescription;
  late String place;
  late String icon;
  late String message;
  late double temp;
  void initState() {
    // TODO: implement initState
    super.initState();

    var id = widget.weatherData["id"];
    icon = weatherModal.getWeatherIcon(id);
    weatherDescription = widget.weatherData['weather'];
    temp = widget.weatherData['temp'];
    if (id != 0)
      message = weatherModal.getMessage(temp.toInt());
    else
      message = "Error";
    place = widget.weatherData['place'];
  }

  @override
  Widget build(BuildContext context) {
    void updateUI(cityName) async {
      late Map weatherData;
      if (cityName == null) {
        weatherData = await weatherModal.getLocationWeatherData();
      } else
        weatherData = await weatherModal.getCityWeatherData(cityName);
      var id = weatherData["id"];
      setState(() {
        icon = weatherModal.getWeatherIcon(id);
        weatherDescription = weatherData['weather'];
        temp = weatherData['temp'];
        if (id != 0)
          message = weatherModal.getMessage(temp.toInt());
        else
          message = "Error";
        place = weatherData['place'];
      });
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        updateUI(null);
                      },
                      child: Icon(
                        Icons.near_me,
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var cityName = await Navigator.push(context,
                            MaterialPageRoute(builder: (contest) {
                          return CityScreen();
                        }));
                        if (cityName != null) {
                          updateUI(cityName);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Text(
                          '$temp°',
                          style: kTempTextStyle,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(icon, style: kButtonTextStyle),
                      )
                    ],
                  ),
                ),
              ),
              // Expanded(
              //     flex: 3,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //
              //         Text(
              //           weatherDescription,
              //           style: kButtonTextStyle,
              //         ),
              //       ],
              //     )),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "$message $place !",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
