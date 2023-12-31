import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static Future getWeatherDataByCity(String city) async {
    return await http.get(
        Uri.parse(
            "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=İstanbul"),
        headers: {
          HttpHeaders.authorizationHeader:
              'apikey 3VHFAsT5AtRQZkTiLggich:19aPpqjH8KI2XJGV3ZhWLo',
          HttpHeaders.contentTypeHeader: 'application/json'
        });
  }
}
