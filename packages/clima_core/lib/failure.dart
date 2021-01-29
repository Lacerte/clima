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

class FailedToParseResponse extends Failure {
  const FailedToParseResponse();

  @override
  List<Object> get props => const [];
}
