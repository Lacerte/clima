import 'package:clima_core/failure.dart';
import 'package:clima_data/models/city_model.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CityLocalDataSource {
  Future<Either<Failure, CityModel>> getCity();

  Future<Either<Failure, void>> setCity(City city);
}

class CityLocalDataSourceImpl implements CityLocalDataSource {
  @override
  Future<Either<Failure, CityModel>> getCity() async {
    final prefs = await SharedPreferences.getInstance();

    final cityName = prefs.getString('name');
    if (cityName == null) return const Right(null);

    return Right(CityModel(City(name: cityName)));
  }

  @override
  Future<Either<Failure, void>> setCity(City city) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', city.name);

    return const Right(null);
  }
}

final cityLocalDataSourceProvider =
    Provider<CityLocalDataSource>((ref) => CityLocalDataSourceImpl());
