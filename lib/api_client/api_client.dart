import 'dart:convert';

import 'package:friflex_weather_test/entities/weather.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String _appid = '80efa84b8887b5dafbe09e3a61f1e425';
  static const String _host = 'http://api.openweathermap.org/data/2.5/forecast';

  Uri _makeUri([Map<String, dynamic>? parametrs]) {
    final uri = Uri.parse('$_host');
    if (parametrs != null) {
      return uri.replace(queryParameters: parametrs);
    } else {
      return uri;
    }
  }

  Future<Data> fetchWeather(String city) async {
    final response =
        await http.get(_makeUri({'q': city, 'appid': '$_appid', 'lang': 'ru'}));
    // if (response.statusCode == 200) {
    try {
      if (response.statusCode == 200) {
        final data = Data.fromJson(jsonDecode(response.body));
        return data;
      } else {
        throw Exception();
      }
    } on Exception {
      rethrow;
    }

    // } else {

    //   throw Exception('exception');

    // }
  }
}
