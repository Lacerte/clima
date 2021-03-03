import 'package:clima_domain/entities/forecast.dart';
import 'package:meta/meta.dart';

class ForecastModel extends Forecast {
  ForecastModel({
    @required double temperature,
    @required int time,
    @required String iconCode,
  }) : super(
          temperature: temperature,
          time: time,
          iconCode: iconCode,
        );

  factory ForecastModel.fromJson(Map<String, dynamic> json) => ForecastModel(
        temperature: (json['main']['temp'] as num).toDouble(),
        time: (json['dt'] as num).toInt(),
        iconCode: json['weather'][0]['icon'] as String,
      );
}
