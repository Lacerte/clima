import 'package:clima_core/failure.dart';
import 'package:clima_data/data_sources/city_local_data_source.dart';
import 'package:clima_data/data_sources/city_random_data_source.dart';
import 'package:clima_data/models/city_model.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/repos/city_repo.dart';
import 'package:clima_domain/repos/weather_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';

class CityRepoImpl implements CityRepo {
  final CityLocalDataSource localDataSource;

  final CityRandomDataSource randomDataSource;

  final WeatherRepo weatherRepo;

  CityRepoImpl({
    required this.localDataSource,
    required this.randomDataSource,
    required this.weatherRepo,
  });

  @override
  Future<Either<Failure, ApiKey>> getCity() async {
    final cityEither = await localDataSource.getCity();

    if (cityEither.isLeft()) {
      return cityEither.map((model) => model!.city);
    }

    final cityModel = (cityEither as Right<Failure, CityModel?>).value;

    if (cityModel == null) {
      return (await randomDataSource.getCity()).map((model) => model.city);
    }

    return Right(cityModel.city);
  }

  @override
  Future<Either<Failure, void>> setCity(ApiKey city) async {
    final weather = await weatherRepo.getWeather(city);

    return weather.fold(
      (failure) async => Left(failure),
      (weather) => localDataSource.setCity(ApiKey(name: weather.cityName)),
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
