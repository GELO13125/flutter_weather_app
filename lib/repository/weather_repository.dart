import 'dart:convert';
import 'package:flutter_weather_app/model/weather.dart';
import 'package:http/http.dart' as http;
import '../core/constants.dart';

class WeatherRepository {
  final http.Client httpClient;
  WeatherRepository({http.Client? httpClient})
    : httpClient = httpClient ?? http.Client();

  Future<Weather> fetchWeather(String city) async {
    final uri = Uri.parse(
      '$BASE_URL?q=${Uri.encodeComponent(city)}&appid=$OPENWEATHER_API_KEY',
    );
    final res = await httpClient.get(uri);

    if (res.statusCode != 200) {
      throw Exception('Error fetching weather: ${res.statusCode}');
    }

    final json = jsonDecode(res.body) as Map<String, dynamic>;
    return Weather.fromJson(json);
  }
}
