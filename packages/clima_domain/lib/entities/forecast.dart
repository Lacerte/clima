import 'package:clima_core/equatable.dart';
import 'package:meta/meta.dart';

class Forecast with Equatable<Forecast> {
  /// In degrees Celsius (for now).
  final double temperature;
  final int time;
  final String iconCode;

  Forecast({
    @required this.temperature,
    @required this.iconCode,
    @required this.time,
  });

  @override
  bool get checkRuntimeType => false;

  @override
  // TODO: implement props
  List<Object> get props => [
        temperature,
        iconCode,
        time,
      ];
}
