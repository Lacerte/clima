import 'package:clima_data/models/forecast_model.dart';
import 'package:clima_data/models/forecasts_model.dart';
import 'package:test/test.dart';

void main() {
  group('ForecastsModel', () {
    test('fromJson', () {
      // Fetched from the API.
      const json = {
        "cod": "200",
        "message": 0,
        "cnt": 40,
        "list": [
          {
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
          },
          {
            "dt": 1615129200,
            "main": {
              "temp": 6.81,
              "feels_like": 3.21,
              "temp_min": 6.81,
              "temp_max": 7.43,
              "pressure": 1026,
              "sea_level": 1026,
              "grnd_level": 1022,
              "humidity": 53,
              "temp_kf": -0.62
            },
            "weather": [
              {
                "id": 801,
                "main": "Clouds",
                "description": "few clouds",
                "icon": "02d"
              }
            ],
            "clouds": {"all": 19},
            "wind": {"speed": 1.89, "deg": 3},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2021-03-07 15:00:00"
          },
          {
            "dt": 1615140000,
            "main": {
              "temp": 5.84,
              "feels_like": 2.64,
              "temp_min": 5.84,
              "temp_max": 5.93,
              "pressure": 1025,
              "sea_level": 1025,
              "grnd_level": 1021,
              "humidity": 61,
              "temp_kf": -0.09
            },
            "weather": [
              {
                "id": 800,
                "main": "Clear",
                "description": "clear sky",
                "icon": "01n"
              }
            ],
            "clouds": {"all": 6},
            "wind": {"speed": 1.51, "deg": 18},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-07 18:00:00"
          },
          {
            "dt": 1615150800,
            "main": {
              "temp": 4.44,
              "feels_like": 2.16,
              "temp_min": 4.44,
              "temp_max": 4.44,
              "pressure": 1025,
              "sea_level": 1025,
              "grnd_level": 1022,
              "humidity": 68,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 800,
                "main": "Clear",
                "description": "clear sky",
                "icon": "01n"
              }
            ],
            "clouds": {"all": 1},
            "wind": {"speed": 0.23, "deg": 321},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-07 21:00:00"
          },
          {
            "dt": 1615161600,
            "main": {
              "temp": 3.38,
              "feels_like": 0.75,
              "temp_min": 3.38,
              "temp_max": 3.38,
              "pressure": 1025,
              "sea_level": 1025,
              "grnd_level": 1022,
              "humidity": 74,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 800,
                "main": "Clear",
                "description": "clear sky",
                "icon": "01n"
              }
            ],
            "clouds": {"all": 0},
            "wind": {"speed": 0.76, "deg": 267},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-08 00:00:00"
          },
          {
            "dt": 1615172400,
            "main": {
              "temp": 2.61,
              "feels_like": -0.36,
              "temp_min": 2.61,
              "temp_max": 2.61,
              "pressure": 1024,
              "sea_level": 1024,
              "grnd_level": 1021,
              "humidity": 79,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 800,
                "main": "Clear",
                "description": "clear sky",
                "icon": "01n"
              }
            ],
            "clouds": {"all": 0},
            "wind": {"speed": 1.27, "deg": 271},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-08 03:00:00"
          },
          {
            "dt": 1615183200,
            "main": {
              "temp": 2.03,
              "feels_like": -0.85,
              "temp_min": 2.03,
              "temp_max": 2.03,
              "pressure": 1024,
              "sea_level": 1024,
              "grnd_level": 1021,
              "humidity": 83,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 800,
                "main": "Clear",
                "description": "clear sky",
                "icon": "01n"
              }
            ],
            "clouds": {"all": 0},
            "wind": {"speed": 1.17, "deg": 271},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-08 06:00:00"
          },
          {
            "dt": 1615194000,
            "main": {
              "temp": 3.9,
              "feels_like": 1.23,
              "temp_min": 3.9,
              "temp_max": 3.9,
              "pressure": 1024,
              "sea_level": 1024,
              "grnd_level": 1021,
              "humidity": 73,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 804,
                "main": "Clouds",
                "description": "overcast clouds",
                "icon": "04d"
              }
            ],
            "clouds": {"all": 93},
            "wind": {"speed": 0.87, "deg": 254},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2021-03-08 09:00:00"
          },
          {
            "dt": 1615204800,
            "main": {
              "temp": 7.47,
              "feels_like": 4.34,
              "temp_min": 7.47,
              "temp_max": 7.47,
              "pressure": 1024,
              "sea_level": 1024,
              "grnd_level": 1021,
              "humidity": 57,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 804,
                "main": "Clouds",
                "description": "overcast clouds",
                "icon": "04d"
              }
            ],
            "clouds": {"all": 97},
            "wind": {"speed": 1.53, "deg": 263},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2021-03-08 12:00:00"
          },
          {
            "dt": 1615215600,
            "main": {
              "temp": 9.13,
              "feels_like": 5.97,
              "temp_min": 9.13,
              "temp_max": 9.13,
              "pressure": 1023,
              "sea_level": 1023,
              "grnd_level": 1020,
              "humidity": 52,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 804,
                "main": "Clouds",
                "description": "overcast clouds",
                "icon": "04d"
              }
            ],
            "clouds": {"all": 100},
            "wind": {"speed": 1.63, "deg": 275},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2021-03-08 15:00:00"
          },
          {
            "dt": 1615226400,
            "main": {
              "temp": 7.65,
              "feels_like": 4.96,
              "temp_min": 7.65,
              "temp_max": 7.65,
              "pressure": 1022,
              "sea_level": 1022,
              "grnd_level": 1019,
              "humidity": 61,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 804,
                "main": "Clouds",
                "description": "overcast clouds",
                "icon": "04n"
              }
            ],
            "clouds": {"all": 100},
            "wind": {"speed": 1.14, "deg": 272},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-08 18:00:00"
          },
          {
            "dt": 1615237200,
            "main": {
              "temp": 6.1,
              "feels_like": 3.06,
              "temp_min": 6.1,
              "temp_max": 6.1,
              "pressure": 1023,
              "sea_level": 1023,
              "grnd_level": 1020,
              "humidity": 71,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 804,
                "main": "Clouds",
                "description": "overcast clouds",
                "icon": "04n"
              }
            ],
            "clouds": {"all": 89},
            "wind": {"speed": 1.78, "deg": 264},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-08 21:00:00"
          },
          {
            "dt": 1615248000,
            "main": {
              "temp": 4.6,
              "feels_like": 1.24,
              "temp_min": 4.6,
              "temp_max": 4.6,
              "pressure": 1022,
              "sea_level": 1022,
              "grnd_level": 1019,
              "humidity": 75,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 803,
                "main": "Clouds",
                "description": "broken clouds",
                "icon": "04n"
              }
            ],
            "clouds": {"all": 74},
            "wind": {"speed": 2.08, "deg": 257},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-09 00:00:00"
          },
          {
            "dt": 1615258800,
            "main": {
              "temp": 3.5,
              "feels_like": -0.08,
              "temp_min": 3.5,
              "temp_max": 3.5,
              "pressure": 1021,
              "sea_level": 1021,
              "grnd_level": 1018,
              "humidity": 77,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 800,
                "main": "Clear",
                "description": "clear sky",
                "icon": "01n"
              }
            ],
            "clouds": {"all": 0},
            "wind": {"speed": 2.25, "deg": 252},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-09 03:00:00"
          },
          {
            "dt": 1615269600,
            "main": {
              "temp": 2.56,
              "feels_like": -0.81,
              "temp_min": 2.56,
              "temp_max": 2.56,
              "pressure": 1021,
              "sea_level": 1021,
              "grnd_level": 1018,
              "humidity": 82,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 800,
                "main": "Clear",
                "description": "clear sky",
                "icon": "01n"
              }
            ],
            "clouds": {"all": 0},
            "wind": {"speed": 1.93, "deg": 242},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-09 06:00:00"
          },
          {
            "dt": 1615280400,
            "main": {
              "temp": 4.52,
              "feels_like": 0.52,
              "temp_min": 4.52,
              "temp_max": 4.52,
              "pressure": 1021,
              "sea_level": 1021,
              "grnd_level": 1018,
              "humidity": 73,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 800,
                "main": "Clear",
                "description": "clear sky",
                "icon": "01d"
              }
            ],
            "clouds": {"all": 6},
            "wind": {"speed": 2.9, "deg": 241},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2021-03-09 09:00:00"
          },
          {
            "dt": 1615291200,
            "main": {
              "temp": 9.49,
              "feels_like": 5.06,
              "temp_min": 9.49,
              "temp_max": 9.49,
              "pressure": 1020,
              "sea_level": 1020,
              "grnd_level": 1017,
              "humidity": 53,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 800,
                "main": "Clear",
                "description": "clear sky",
                "icon": "01d"
              }
            ],
            "clouds": {"all": 4},
            "wind": {"speed": 3.57, "deg": 226},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2021-03-09 12:00:00"
          },
          {
            "dt": 1615302000,
            "main": {
              "temp": 10.77,
              "feels_like": 5.84,
              "temp_min": 10.77,
              "temp_max": 10.77,
              "pressure": 1018,
              "sea_level": 1018,
              "grnd_level": 1015,
              "humidity": 55,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 802,
                "main": "Clouds",
                "description": "scattered clouds",
                "icon": "03d"
              }
            ],
            "clouds": {"all": 33},
            "wind": {"speed": 4.67, "deg": 227},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2021-03-09 15:00:00"
          },
          {
            "dt": 1615312800,
            "main": {
              "temp": 7.94,
              "feels_like": 3.17,
              "temp_min": 7.94,
              "temp_max": 7.94,
              "pressure": 1017,
              "sea_level": 1017,
              "grnd_level": 1014,
              "humidity": 72,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 803,
                "main": "Clouds",
                "description": "broken clouds",
                "icon": "04n"
              }
            ],
            "clouds": {"all": 66},
            "wind": {"speed": 4.72, "deg": 218},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-09 18:00:00"
          },
          {
            "dt": 1615323600,
            "main": {
              "temp": 7.07,
              "feels_like": 1.64,
              "temp_min": 7.07,
              "temp_max": 7.07,
              "pressure": 1016,
              "sea_level": 1016,
              "grnd_level": 1013,
              "humidity": 76,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 804,
                "main": "Clouds",
                "description": "overcast clouds",
                "icon": "04n"
              }
            ],
            "clouds": {"all": 100},
            "wind": {"speed": 5.64, "deg": 213},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-09 21:00:00"
          },
          {
            "dt": 1615334400,
            "main": {
              "temp": 7.03,
              "feels_like": 1.06,
              "temp_min": 7.03,
              "temp_max": 7.03,
              "pressure": 1014,
              "sea_level": 1014,
              "grnd_level": 1011,
              "humidity": 76,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 804,
                "main": "Clouds",
                "description": "overcast clouds",
                "icon": "04n"
              }
            ],
            "clouds": {"all": 100},
            "wind": {"speed": 6.41, "deg": 211},
            "visibility": 10000,
            "pop": 0.12,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-10 00:00:00"
          },
          {
            "dt": 1615345200,
            "main": {
              "temp": 7.03,
              "feels_like": -0.2,
              "temp_min": 7.03,
              "temp_max": 7.03,
              "pressure": 1011,
              "sea_level": 1011,
              "grnd_level": 1008,
              "humidity": 74,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 500,
                "main": "Rain",
                "description": "light rain",
                "icon": "10n"
              }
            ],
            "clouds": {"all": 100},
            "wind": {"speed": 8.11, "deg": 203},
            "visibility": 10000,
            "pop": 0.82,
            "rain": {"3h": 1.34},
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-10 03:00:00"
          },
          {
            "dt": 1615356000,
            "main": {
              "temp": 7.29,
              "feels_like": 0.7,
              "temp_min": 7.29,
              "temp_max": 7.29,
              "pressure": 1009,
              "sea_level": 1009,
              "grnd_level": 1006,
              "humidity": 83,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 500,
                "main": "Rain",
                "description": "light rain",
                "icon": "10n"
              }
            ],
            "clouds": {"all": 100},
            "wind": {"speed": 7.69, "deg": 206},
            "visibility": 10000,
            "pop": 1,
            "rain": {"3h": 1.24},
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-10 06:00:00"
          },
          {
            "dt": 1615366800,
            "main": {
              "temp": 8.31,
              "feels_like": 1.73,
              "temp_min": 8.31,
              "temp_max": 8.31,
              "pressure": 1007,
              "sea_level": 1007,
              "grnd_level": 1004,
              "humidity": 84,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 500,
                "main": "Rain",
                "description": "light rain",
                "icon": "10d"
              }
            ],
            "clouds": {"all": 100},
            "wind": {"speed": 8.02, "deg": 206},
            "visibility": 10000,
            "pop": 1,
            "rain": {"3h": 1.54},
            "sys": {"pod": "d"},
            "dt_txt": "2021-03-10 09:00:00"
          },
          {
            "dt": 1615377600,
            "main": {
              "temp": 9.14,
              "feels_like": 2.16,
              "temp_min": 9.14,
              "temp_max": 9.14,
              "pressure": 1005,
              "sea_level": 1005,
              "grnd_level": 1002,
              "humidity": 85,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 500,
                "main": "Rain",
                "description": "light rain",
                "icon": "10d"
              }
            ],
            "clouds": {"all": 100},
            "wind": {"speed": 8.9, "deg": 209},
            "visibility": 10000,
            "pop": 1,
            "rain": {"3h": 1.11},
            "sys": {"pod": "d"},
            "dt_txt": "2021-03-10 12:00:00"
          },
          {
            "dt": 1615388400,
            "main": {
              "temp": 9.94,
              "feels_like": 3.28,
              "temp_min": 9.94,
              "temp_max": 9.94,
              "pressure": 1002,
              "sea_level": 1002,
              "grnd_level": 999,
              "humidity": 88,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 500,
                "main": "Rain",
                "description": "light rain",
                "icon": "10d"
              }
            ],
            "clouds": {"all": 100},
            "wind": {"speed": 8.87, "deg": 215},
            "visibility": 8800,
            "pop": 1,
            "rain": {"3h": 1.41},
            "sys": {"pod": "d"},
            "dt_txt": "2021-03-10 15:00:00"
          },
          {
            "dt": 1615399200,
            "main": {
              "temp": 11.45,
              "feels_like": 5.49,
              "temp_min": 11.45,
              "temp_max": 11.45,
              "pressure": 999,
              "sea_level": 999,
              "grnd_level": 996,
              "humidity": 87,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 500,
                "main": "Rain",
                "description": "light rain",
                "icon": "10n"
              }
            ],
            "clouds": {"all": 100},
            "wind": {"speed": 8.34, "deg": 223},
            "visibility": 10000,
            "pop": 1,
            "rain": {"3h": 2.62},
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-10 18:00:00"
          },
          {
            "dt": 1615410000,
            "main": {
              "temp": 12.27,
              "feels_like": 4.43,
              "temp_min": 12.27,
              "temp_max": 12.27,
              "pressure": 996,
              "sea_level": 996,
              "grnd_level": 993,
              "humidity": 80,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 500,
                "main": "Rain",
                "description": "light rain",
                "icon": "10n"
              }
            ],
            "clouds": {"all": 100},
            "wind": {"speed": 10.86, "deg": 219},
            "visibility": 10000,
            "pop": 0.41,
            "rain": {"3h": 0.25},
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-10 21:00:00"
          },
          {
            "dt": 1615420800,
            "main": {
              "temp": 11.93,
              "feels_like": 2.34,
              "temp_min": 11.93,
              "temp_max": 11.93,
              "pressure": 995,
              "sea_level": 995,
              "grnd_level": 992,
              "humidity": 66,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 500,
                "main": "Rain",
                "description": "light rain",
                "icon": "10n"
              }
            ],
            "clouds": {"all": 100},
            "wind": {"speed": 12.32, "deg": 235},
            "visibility": 10000,
            "pop": 0.42,
            "rain": {"3h": 0.28},
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-11 00:00:00"
          },
          {
            "dt": 1615431600,
            "main": {
              "temp": 9.68,
              "feels_like": -0.94,
              "temp_min": 9.68,
              "temp_max": 9.68,
              "pressure": 994,
              "sea_level": 994,
              "grnd_level": 991,
              "humidity": 59,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 804,
                "main": "Clouds",
                "description": "overcast clouds",
                "icon": "04n"
              }
            ],
            "clouds": {"all": 98},
            "wind": {"speed": 12.8, "deg": 241},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-11 03:00:00"
          },
          {
            "dt": 1615442400,
            "main": {
              "temp": 8.28,
              "feels_like": -0.6,
              "temp_min": 8.28,
              "temp_max": 8.28,
              "pressure": 998,
              "sea_level": 998,
              "grnd_level": 995,
              "humidity": 62,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 804,
                "main": "Clouds",
                "description": "overcast clouds",
                "icon": "04n"
              }
            ],
            "clouds": {"all": 91},
            "wind": {"speed": 10.16, "deg": 251},
            "visibility": 10000,
            "pop": 0.17,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-11 06:00:00"
          },
          {
            "dt": 1615453200,
            "main": {
              "temp": 8.43,
              "feels_like": -0.3,
              "temp_min": 8.43,
              "temp_max": 8.43,
              "pressure": 1000,
              "sea_level": 1000,
              "grnd_level": 997,
              "humidity": 60,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 804,
                "main": "Clouds",
                "description": "overcast clouds",
                "icon": "04d"
              }
            ],
            "clouds": {"all": 93},
            "wind": {"speed": 9.87, "deg": 250},
            "visibility": 10000,
            "pop": 0.14,
            "sys": {"pod": "d"},
            "dt_txt": "2021-03-11 09:00:00"
          },
          {
            "dt": 1615464000,
            "main": {
              "temp": 10.38,
              "feels_like": 1.6,
              "temp_min": 10.38,
              "temp_max": 10.38,
              "pressure": 1001,
              "sea_level": 1001,
              "grnd_level": 998,
              "humidity": 49,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 500,
                "main": "Rain",
                "description": "light rain",
                "icon": "10d"
              }
            ],
            "clouds": {"all": 97},
            "wind": {"speed": 9.74, "deg": 254},
            "visibility": 6441,
            "pop": 0.65,
            "rain": {"3h": 0.44},
            "sys": {"pod": "d"},
            "dt_txt": "2021-03-11 12:00:00"
          },
          {
            "dt": 1615474800,
            "main": {
              "temp": 9.77,
              "feels_like": 1.32,
              "temp_min": 9.77,
              "temp_max": 9.77,
              "pressure": 1001,
              "sea_level": 1001,
              "grnd_level": 998,
              "humidity": 53,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 500,
                "main": "Rain",
                "description": "light rain",
                "icon": "10d"
              }
            ],
            "clouds": {"all": 100},
            "wind": {"speed": 9.38, "deg": 253},
            "visibility": 10000,
            "pop": 1,
            "rain": {"3h": 0.81},
            "sys": {"pod": "d"},
            "dt_txt": "2021-03-11 15:00:00"
          },
          {
            "dt": 1615485600,
            "main": {
              "temp": 7.82,
              "feels_like": -0.75,
              "temp_min": 7.82,
              "temp_max": 7.82,
              "pressure": 1002,
              "sea_level": 1002,
              "grnd_level": 999,
              "humidity": 57,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 500,
                "main": "Rain",
                "description": "light rain",
                "icon": "10n"
              }
            ],
            "clouds": {"all": 100},
            "wind": {"speed": 9.37, "deg": 257},
            "visibility": 10000,
            "pop": 1,
            "rain": {"3h": 0.49},
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-11 18:00:00"
          },
          {
            "dt": 1615496400,
            "main": {
              "temp": 6.66,
              "feels_like": -1.22,
              "temp_min": 6.66,
              "temp_max": 6.66,
              "pressure": 1004,
              "sea_level": 1004,
              "grnd_level": 1001,
              "humidity": 61,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 802,
                "main": "Clouds",
                "description": "scattered clouds",
                "icon": "03n"
              }
            ],
            "clouds": {"all": 33},
            "wind": {"speed": 8.35, "deg": 256},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-11 21:00:00"
          },
          {
            "dt": 1615507200,
            "main": {
              "temp": 6.14,
              "feels_like": -0.78,
              "temp_min": 6.14,
              "temp_max": 6.14,
              "pressure": 1006,
              "sea_level": 1006,
              "grnd_level": 1003,
              "humidity": 64,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 801,
                "main": "Clouds",
                "description": "few clouds",
                "icon": "02n"
              }
            ],
            "clouds": {"all": 21},
            "wind": {"speed": 7.02, "deg": 255},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-12 00:00:00"
          },
          {
            "dt": 1615518000,
            "main": {
              "temp": 5.75,
              "feels_like": -1.21,
              "temp_min": 5.75,
              "temp_max": 5.75,
              "pressure": 1007,
              "sea_level": 1007,
              "grnd_level": 1004,
              "humidity": 66,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 802,
                "main": "Clouds",
                "description": "scattered clouds",
                "icon": "03n"
              }
            ],
            "clouds": {"all": 50},
            "wind": {"speed": 7.09, "deg": 251},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-12 03:00:00"
          },
          {
            "dt": 1615528800,
            "main": {
              "temp": 5.43,
              "feels_like": -1.37,
              "temp_min": 5.43,
              "temp_max": 5.43,
              "pressure": 1007,
              "sea_level": 1007,
              "grnd_level": 1004,
              "humidity": 74,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 802,
                "main": "Clouds",
                "description": "scattered clouds",
                "icon": "03n"
              }
            ],
            "clouds": {"all": 39},
            "wind": {"speed": 7.13, "deg": 243},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "n"},
            "dt_txt": "2021-03-12 06:00:00"
          },
          {
            "dt": 1615539600,
            "main": {
              "temp": 7.93,
              "feels_like": 0.49,
              "temp_min": 7.93,
              "temp_max": 7.93,
              "pressure": 1007,
              "sea_level": 1007,
              "grnd_level": 1004,
              "humidity": 59,
              "temp_kf": 0
            },
            "weather": [
              {
                "id": 803,
                "main": "Clouds",
                "description": "broken clouds",
                "icon": "04d"
              }
            ],
            "clouds": {"all": 77},
            "wind": {"speed": 7.88, "deg": 245},
            "visibility": 10000,
            "pop": 0,
            "sys": {"pod": "d"},
            "dt_txt": "2021-03-12 09:00:00"
          }
        ],
        "city": {
          "id": 2643743,
          "name": "London",
          "coord": {"lat": 51.5085, "lon": -0.1257},
          "country": "GB",
          "population": 1000000,
          "timezone": 0,
          "sunrise": 1615098752,
          "sunset": 1615139446,
        },
      };
      expect(
          ForecastsModel.fromJson(json),
          ForecastsModel(
            forecasts: [
              ForecastModel(
                temperature: 5.29,
                timeZoneOffset: const Duration(),
                windSpeed: 1.37,
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
            ],
            cityName: 'London',
          ));
    });
  });
}
