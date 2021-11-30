import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'either.dart';
import 'failure.dart';

abstract class UseCase<R, P> {
  Future<Either<Failure, R>> call(P params);
}

@sealed
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => const [];
}
