import 'package:clima_domain/entities/weather.dart';
import 'package:meta/meta.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    @required double temperature,
    @required double windSpeed,
    @required double tempFeel,
    @required int condition,
    @required double tempMin,
    @required double tempMax,
    @required String cityName,
    @required String description,
  }) : super(
          temperature: temperature,
          windSpeed: windSpeed,
          tempFeel: tempFeel,
          condition: condition,
          tempMin: tempMin,
          tempMax: tempMax,
          cityName: cityName,
          description: description,
        );

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        temperature: (json['main']['temp'] as num).toDouble(),
        tempMax: (json['main']['temp_max'] as num).toDouble(),
        tempMin: (json['main']['temp_min'] as num).toDouble(),
        tempFeel: (json['main']['feels_like'] as num).toDouble(),
        // We multiply by 3.6 to convert from m/s to km/h.
        windSpeed: (json['wind']['speed'] as num).toDouble() * 3.6,
        condition: json['weather'][0]['id'] as int,
        cityName: json['name'] as String,
        description: json['weather'][0]['description'] as String,
      );
}
