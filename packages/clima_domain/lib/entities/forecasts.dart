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
  // TODO: implement checkRuntimeType
  bool get checkRuntimeType => false;

  @override
  // TODO: implement props
  List<Object> get props => [
        forecasts,
      ];
}
