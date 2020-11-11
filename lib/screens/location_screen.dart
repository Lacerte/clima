import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  int condition;
  String weatherIcon;
  String cityName;
  String weatherMessage;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = '🤷‍';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      final double temp = (weatherData['main']['temp'] as num).toDouble();
      temperature = temp.toInt();
      condition = (weatherData['weather'][0]['id'] as num).toInt();
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'] as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('$cityName'),
        leading: IconButton(
          tooltip: 'Refresh',
          //padding: EdgeInsets.all(3),
          onPressed: () async {
            final weatherData = await weather.getLocationWeather();
            updateUI(weatherData);
          },
          icon: const Icon(
            Icons.location_on,
            //size: 40.0,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Search',
            //padding: EdgeInsets.all(3),
            onPressed: () async {
              final String typedName = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CityScreen();
                  },
                ),
              );
              if (typedName != null) {
                final weatherData = await weather.getCityWeather(typedName);
                updateUI(weatherData);
              }
            },
            icon: const Icon(
              Icons.search,
              // size: 40.0,
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF171717),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            '$temperature°',
                            style: kTempTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            weatherIcon,
                            style: kTempTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF171717),
                  ),
                  margin: const EdgeInsets.all(15),
                  child: const Center(
                    child: Text(
                      'Still to be determined',
                      style: kMessageTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF171717),
                  ),
                  margin: const EdgeInsets.all(15),
                  child: Center(
                    child: Text(
                      '$weatherMessage.',
                      textAlign: TextAlign.center,
                      style: kMessageTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
