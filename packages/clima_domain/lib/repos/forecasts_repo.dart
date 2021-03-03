import 'package:clima_core/failure.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/forecasts.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';

abstract class ForcastsRepo {
  Future<Either<Failure, Forecasts>> getForcasts(City city);
}

final weatherRepoProvider =
    Provider<ForcastsRepo>((ref) => throw UnimplementedError());
