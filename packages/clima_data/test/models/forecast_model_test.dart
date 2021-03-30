import 'package:clima_data/models/forecast_model.dart';
import 'package:test/test.dart';

void main() {
  group('ForecastModel', () {
    test('fromJson', () {
      const json = {
        "dt": 1615118400,
        "main": {
          "temp": 5.29,
          "feels_like": 1.94,
          "temp_min": 5.29,
          "temp_max": 6.05,
          "pressure": 1028,
          "sea_level": 1028,
          "grnd_level": 1024,
          "humidity": 55,
          "temp_kf": -0.76
        },
        "weather": [
          {
            "id": 802,
            "main": "Clouds",
            "description": "scattered clouds",
            "icon": "03d"
          }
        ],
        "clouds": {"all": 46},
        "wind": {"speed": 1.37, "deg": 0},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "d"},
        "dt_txt": "2021-03-07 12:00:00"
      };
      expect(
        ForecastModel.fromJson(json, cityName: 'London'),
        ForecastModel(
          temperature: 5.29,
          windSpeed: 1.37,
          timeZoneOffset: const Duration(),
          tempFeel: 1.94,
          condition: 2643743,
          tempMin: 5.29,
          tempMax: 6.05,
          cityName: 'London',
          description: 'scattered clouds',
          date: DateTime.fromMillisecondsSinceEpoch(1615118400 * 1000),
          sunrise: 1615098752,
          sunset: 1615139446,
          humidity: 55,
          iconCode: '03d',
        ),
      );
    });
  });
}
