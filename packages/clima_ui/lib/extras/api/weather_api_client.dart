import 'dart:convert';

import 'package:clima_ui/extras/model/weather.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

/// Wrapper around the open weather map api
/// https://openweathermap.org/current
class WeatherApiClient {
  WeatherApiClient({@required this.httpClient})
      : assert(httpClient != null),
        assert(apiKey != null);

  static const baseUrl = 'http://api.openweathermap.org';
  static const apiKey = '4bef3adf2fcb90307c2bf5feac75a2ba';
  final http.Client httpClient;

  Future<String> getCityNameFromLocation(
      {double latitude, double longitude}) async {
    final url =
        '$baseUrl/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';
    final res = await httpClient.get(url);

    final dynamic weatherJson = json.decode(res.body);
    return weatherJson['name'] as String;
  }

  Future<Weather> getWeatherData(String cityName) async {
    final url = '$baseUrl/data/2.5/weather?q=$cityName&appid=$apiKey';
    final res = await httpClient.get(url);
    final dynamic weatherJson = json.decode(res.body);
    return Weather.fromJson(weatherJson);
  }

  Future<List<Weather>> getForecast(String cityName) async {
    final url = '$baseUrl/data/2.5/forecast?q=$cityName&appid=$apiKey';
    final res = await httpClient.get(url);
    final forecastJson = json.decode(res.body);
    final List<Weather> weathers = Weather.fromForecastJson(forecastJson);
    return weathers;
  }
}
