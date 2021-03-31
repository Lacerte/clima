import 'package:clima_domain/entities/forecasts.dart';
import 'package:equatable/equatable.dart';

import 'forecast_model.dart';

class ForecastsModel extends Equatable {
  const ForecastsModel(this.forecasts);

  final Forecasts forecasts;

  factory ForecastsModel.fromJson(Map<String, dynamic> json) {
    final list = json['list'] as List<dynamic>;
    final cityName = json['city']['name'] as String;
    final timeZoneOffset = Duration(seconds: json['city']['timezone'] as int);

    return ForecastsModel(
      Forecasts(
        cityName: cityName,
        forecasts: list
            .map(
              (json) => ForecastModel.fromJson(
                json as Map<String, dynamic>,
                cityName: cityName,
                timeZoneOffset: timeZoneOffset,
              ).forecast,
            )
            .toList(),
      ),
    );
  }

  @override
  List<Object> get props => [forecasts];
}
