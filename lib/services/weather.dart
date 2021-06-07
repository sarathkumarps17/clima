import '../services/location.dart';
import '../services/networking.dart';
import '../utilities/constants.dart';

Location location = Location();

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition == 0) {
      return '🤷';
    } else if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Future getCityWeatherData(cityName) async {
    late Map weatherData;
    NetworkHelper api = NetworkHelper(
        uri:
            'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$kAPI_ID');
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
            'http://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$kAPI_ID');
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
