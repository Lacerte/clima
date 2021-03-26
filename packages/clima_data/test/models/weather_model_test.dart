import 'package:clima_data/models/weather_model.dart';
import 'package:test/test.dart';

void main() {
  group('WeatherModel', () {
    test('fromJson', () {
      // Fetched from the API.
      const json = {
        'coord': {'lon': -0.1257, 'lat': 51.5085},
        'weather': [
          {
            'id': 803,
            'main': 'Clouds',
            'description': 'broken clouds',
            'icon': '04d'
          }
        ],
        'base': 'stations',
        'main': {
          'temp': 8.4,
          'feels_like': 5.98,
          'temp_min': 7.78,
          'temp_max': 8.89,
          'pressure': 996,
          'humidity': 93
        },
        'visibility': 6000,
        'wind': {'speed': 2.57, 'deg': 290},
        'clouds': {'all': 75},
        'dt': 1611919888,
        'sys': {
          'type': 1,
          'id': 1414,
          'country': 'GB',
          'sunrise': 1611906189,
          'sunset': 1611938637
        },
        'timezone': 0,
        'id': 2643743,
        'name': 'London',
        'cod': 200,
      };

      expect(
        WeatherModel.fromJson(json),
        WeatherModel(
          cityName: 'London',
          condition: 803,
          tempMax: 8.89,
          description: 'broken clouds',
          tempMin: 7.78,
          tempFeel: 5.98,
          windSpeed: 2.57 * 3.6,
          temperature: 8.4,
          iconCode: '04d',
          humidity: 93,
          sunrise: 1611906189,
          sunset: 1611938637,
          //  date: 1611919888,
          date: DateTime.fromMillisecondsSinceEpoch(1611919888 * 1000),
        ),
      );
    });
  });
}
