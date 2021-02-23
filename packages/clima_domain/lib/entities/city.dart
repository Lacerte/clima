import 'package:clima_core/equatable.dart';
import 'package:meta/meta.dart';

class City with Equatable<City> {
  const City({@required this.name});

  final String name;

  @override
  bool get checkRuntimeType => false;

  @override
  List<Object> get props => [name];
}
