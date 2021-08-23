import 'package:clima_core/failure.dart';
import 'package:clima_core/use_case.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/repos/city_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';

class GetCity implements UseCase<ApiKey, NoParams> {
  final CityRepo repo;

  const GetCity(this.repo);

  @override
  Future<Either<Failure, ApiKey>> call(NoParams params) => repo.getCity();
}

final getCityProvider = Provider((ref) => GetCity(ref.watch(cityRepoProvider)));
