import 'package:clima_core/failure.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';

abstract class CityRepo {
  Future<Either<Failure, ApiKey>> getCity();

  Future<Either<Failure, void>> setCity(ApiKey city);
}

final cityRepoProvider =
    Provider<CityRepo>((ref) => throw UnimplementedError());
