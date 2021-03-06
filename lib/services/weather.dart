import '../services/location.dart';
import '../services/networking.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

var API_Key = dotenv.env['API_key'];

Location location = Location();

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition == 0) {
      return '๐คท';
    } else if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }

  Future getCityWeatherData(cityName) async {
    late Map weatherData;
    NetworkHelper api = NetworkHelper(
        uri:
            'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$API_Key');
    try {
      return weatherData = await api.getData();
    } catch (e) {
      weatherData = {
        'weather': "Error",
        'place': "Location Not Found",
        'id': 0,
        'temp': 0.0
      };
      return weatherData;
    }
  }

  Future getLocationWeatherData() async {
    late Map weatherData;
    await location.getCurrentLocation();
    double latitude = location.latitude;
    double longitude = location.longitude;
    NetworkHelper api = NetworkHelper(
        uri:
            'http://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$API_Key');
    try {
      return weatherData = await api.getData();
    } catch (e) {
      weatherData = {
        'weather': "Error",
        'place': "Location Not Found",
        'id': 0,
        'temp': 0.0
      };
      return weatherData;
    }
  }
}
