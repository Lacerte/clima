import 'package:clima_domain/entities/forecasts.dart';
import 'package:clima_domain/entities/weather.dart';
import 'package:meta/meta.dart';

import 'forecast_model.dart';

class ForecastsModel extends Forecasts {
  ForecastsModel({
    @required List<Weather> forecasts,
    @required String cityName,
  }) : super(forecasts: forecasts, cityName: cityName);

  factory ForecastsModel.fromJson(Map<String, dynamic> json) {
    final list = json['list'] as List<dynamic>;
    final cityName = json['city']['name'] as String;

    return ForecastsModel(
      cityName: cityName,
      forecasts: list
          .map((e) => ForecastModel.fromJson(e as Map<String, dynamic>,
              cityName: cityName))
          .toList(),
    );
  }
}
