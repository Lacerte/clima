import 'package:clima_core/failure.dart';
import 'package:clima_data/data_sources/city_local_data_source.dart';
import 'package:clima_data/data_sources/city_random_data_source.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/repos/city_repo.dart';
import 'package:clima_domain/repos/weather_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

class CityRepoImpl implements CityRepo {
  final CityLocalDataSource localDataSource;

  final CityRandomDataSource randomDataSource;

  final WeatherRepo weatherRepo;

  CityRepoImpl({
    @required this.localDataSource,
    @required this.randomDataSource,
    @required this.weatherRepo,
  });

  @override
  Future<Either<Failure, City>> getCity() async {
    final cityEither = await localDataSource.getCity();

    if (cityEither.isLeft()) {
      return cityEither;
    }

    final city = (cityEither as Right<Failure, City>).value;

    if (city == null) {
      return randomDataSource.getCity();
    }

    return Right(city);
  }

  @override
  Future<Either<Failure, void>> setCity(City city) async {
    final weather = await weatherRepo.getWeather(city);

    return weather.fold(
      (failure) async => Left(failure),
      (_) => localDataSource.setCity(city),
    );
  }
}

final cityRepoImplProvider = Provider(
  (ref) => CityRepoImpl(
    localDataSource: ref.watch(cityLocalDataSourceProvider),
    randomDataSource: ref.watch(cityRandomDataSourceProvider),
    weatherRepo: ref.watch(weatherRepoProvider),
  ),
);
