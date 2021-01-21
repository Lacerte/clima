import 'package:clima_ui/extras/utils/weather_icon_mapper.dart';
import 'package:flutter/material.dart';

class Weather {
  Weather(
      {this.id,
      this.time,
      this.sunrise,
      this.sunset,
      this.humidity,
      this.description,
      this.iconCode,
      this.main,
      this.cityName,
      this.windSpeed,
      this.temperature,
      this.maxTemperature,
      this.minTemperature,
      this.forecast});

  int id;
  int time;
  int sunrise;
  int sunset;
  int humidity;

  String description;
  String iconCode;
  String main;
  String cityName;

  double windSpeed;

  int temperature;
  int maxTemperature;
  int minTemperature;

  List<Weather> forecast;

  static Weather fromJson(dynamic json) {
    final weather = json['weather'][0];
    return Weather(
      id: (weather['id'] as num).toInt(),
      time: (json['dt'] as num).toInt(),
      description: weather['description'] as String,
      iconCode: weather['icon'] as String,
      main: weather['main'] as String,
      cityName: json['name'] as String,
      temperature: (weather['main']['temp'] as num).round(),
      maxTemperature: (weather['main']['temp_max'] as num).round(),
      minTemperature: (weather['main']['temp_min'] as num).round(),
      sunrise: json['sys']['sunrise'] as int,
      sunset: json['sys']['sunset'] as int,
      humidity: json['main']['humidity'] as int,
      windSpeed: (weather['wind']['speed'] as num).toDouble(),
    );
  }

  static List<Weather> fromForecastJson(Map<String, dynamic> json) {
    final weathers = <Weather>[];
    for (final item in json['list']) {
      weathers.add(
        Weather(
            time: (item['dt'] as num).toInt(),
            temperature: (item['main']['temp'] as num).round(),
            iconCode: item['weather'][0]['icon'] as String),
      );
    }
    return weathers;
  }

  IconData getIconData() {
    switch (iconCode) {
      case '01d':
        return WeatherIcons.clearDay;
      case '01n':
        return WeatherIcons.clearNight;
      case '02d':
        return WeatherIcons.fewCloudsDay;
      case '02n':
        return WeatherIcons.fewCloudsDay;
      case '03d':
      case '04d':
        return WeatherIcons.cloudsDay;
      case '03n':
      case '04n':
        return WeatherIcons.clearNight;
      case '09d':
        return WeatherIcons.showerRainDay;
      case '09n':
        return WeatherIcons.showerRainNight;
      case '10d':
        return WeatherIcons.rainDay;
      case '10n':
        return WeatherIcons.rainNight;
      case '11d':
        return WeatherIcons.thunderStormDay;
      case '11n':
        return WeatherIcons.thunderStormNight;
      case '13d':
        return WeatherIcons.snowDay;
      case '13n':
        return WeatherIcons.snowNight;
      case '50d':
        return WeatherIcons.mistDay;
      case '50n':
        return WeatherIcons.mistNight;
      default:
        return WeatherIcons.clearDay;
    }
  }
}
