import 'networking.dart';

const String apiKey = '4bef3adf2fcb90307c2bf5feac75a2ba';
const String openWeatherMapURL =
    'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  /// This function gets the weatherData using city name.
  Future<dynamic> getCityWeather(String cityName) async {
    final NetworkHelper networkHelper = NetworkHelper(
      '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric',
    );
    final dynamic weatherData = await networkHelper.getData();
    return weatherData;
  }

  /// This function returns the right weather icon for the right condition.
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁';
    } else {
      return '🤷‍';
    }
  }
}
