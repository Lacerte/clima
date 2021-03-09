import 'package:clima_core/equatable.dart';
import 'package:clima_domain/entities/weather.dart';
import 'package:meta/meta.dart';

class Forecasts with Equatable<Forecasts> {
  Forecasts({
    @required this.forecasts,
    @required this.cityName,
  });
  final List<Weather> forecasts;
  final String cityName;
  @override
  bool get checkRuntimeType => false;

  @override
  List<Object> get props => [
        forecasts,
      ];
}
