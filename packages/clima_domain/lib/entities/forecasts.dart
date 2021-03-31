import 'package:clima_domain/entities/weather.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Forecasts extends Equatable {
  const Forecasts({
    @required this.forecasts,
    @required this.cityName,
  });

  final List<Weather> forecasts;

  final String cityName;

  @override
  List<Object> get props => [forecasts, cityName];
}
