import 'package:clima_domain/entities/weather.dart';
import 'package:meta/meta.dart';

class ForecastModel extends Weather {
  ForecastModel({
    @required double temperature,
    @required double windSpeed,
    @required double tempFeel,
    @required int condition,
    @required double tempMin,
    @required double tempMax,
    @required String cityName,
    @required String description,
    @required DateTime date,
    @required int sunrise,
    @required int sunset,
    @required int humidity,
    @required String iconCode,
    @required Duration timeZoneOffset,
  }) : super(
          temperature: temperature,
          windSpeed: windSpeed,
          tempFeel: tempFeel,
          condition: condition,
          minTemperature: tempMin,
          maxTemperature: tempMax,
          cityName: cityName,
          description: description,
          date: date,
          sunrise: sunrise,
          sunset: sunset,
          humidity: humidity,
          iconCode: iconCode,
          timeZoneOffset: timeZoneOffset,
        );

  factory ForecastModel.fromJson(Map<String, dynamic> json,
          {@required String cityName}) =>
      ForecastModel(
          temperature: (json['main']['temp'] as num).toDouble(),
          tempMax: (json['main']['temp_max'] as num).toDouble(),
          tempMin: (json['main']['temp_min'] as num).toDouble(),
          tempFeel: (json['main']['feels_like'] as num).toDouble(),
          // We multiply by 3.6 to convert from m/s to km/h.
          windSpeed: (json['wind']['speed'] as num).toDouble() * 3.6,
          condition: json['weather'][0]['id'] as int,
          cityName: cityName,
          description: json['weather'][0]['description'] as String,
          date: DateTime.fromMillisecondsSinceEpoch((json['dt'] as int) * 1000),
          iconCode: json['weather'][0]['icon'] as String,
          timeZoneOffset: Duration(seconds: json['city']['timezone'] as int),
          sunrise: json['sys']['sunrise'] as int,
          sunset: json['sys']['sunset'] as int,
          humidity: json['main']['humidity'] as int);
}
