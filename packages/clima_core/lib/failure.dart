import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@sealed
abstract class Failure extends Equatable {
  const Failure();
}

class NoConnection extends Failure {
  const NoConnection();

  @override
  List<Object> get props => const [];
}

class ServerDown extends Failure {
  const ServerDown();

  @override
  List<Object> get props => const [];
}

class FailedToParseResponse extends Failure {
  const FailedToParseResponse();

  @override
  List<Object> get props => const [];
}

class InvalidCityName extends Failure {
  const InvalidCityName(this.cityName);

  final String cityName;

  @override
  List<Object> get props => [cityName];
}
