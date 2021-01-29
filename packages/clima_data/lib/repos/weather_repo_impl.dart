import 'package:clima_core/failure.dart';
import 'package:clima_data/data_sources/weather_remote_data_source.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/weather.dart';
import 'package:clima_domain/repos/weather_repo.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

class WeatherRepoImpl implements WeatherRepo {
  final WeatherRemoteDataSource remoteDataSource;

  final Connectivity connectivity;

  WeatherRepoImpl({
    @required this.remoteDataSource,
    @required this.connectivity,
  });

  @override
  Future<Either<Failure, Weather>> getWeather(City city) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      return Left(const NoConnection());
    } else {
      return remoteDataSource.getWeather(city);
    }
  }
}

final weatherRepoImplProvider = Provider(
  (ref) => WeatherRepoImpl(
    remoteDataSource: ref.watch(weatherRemoteDataSourceProvider),
    connectivity: Connectivity(),
  ),
);
