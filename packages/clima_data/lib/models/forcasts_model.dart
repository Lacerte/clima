import 'package:clima_data/models/weather_model.dart';
import 'package:clima_domain/entities/forecasts.dart';
import 'package:clima_domain/entities/weather.dart';
import 'package:meta/meta.dart';

class ForecastsModel extends Forecasts {
  ForecastsModel({
    @required List<Weather> forecasts,
    @required String cityName,
  }) : super(forecasts: forecasts, cityName: cityName);

  factory ForecastsModel.fromJson(Map<String, dynamic> json) {
    final list = json['list'] as List<dynamic>;
    return ForecastsModel(
      forecasts: list.map((e) => WeatherModel.fromJson(e)).toList(),
    );
  }
}
