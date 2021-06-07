import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  String uri;

  NetworkHelper({required this.uri});
  Future<Map> getData() async {
    late Map weatherData;
    var url = Uri.parse(uri);
    http.Response response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      String place = decodedData['city']['name'];
      String weather = decodedData['list'][0]['weather'][0]['main'];
      int id = decodedData['list'][0]['weather'][0]['id'];
      double temp = decodedData['list'][0]['main']['temp'];

      weatherData = {
        'weather': weather,
        'place': place,
        'id': id,
        'temp': (temp - 273.15).ceilToDouble()
      };
    } else
      weatherData = {
        'weather': "Error",
        'place': "API Down",
        'id': 0,
        'temp': 0.0
      };
    return weatherData;
  }
}
