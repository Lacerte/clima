import 'package:auto_size_text/auto_size_text.dart';
import 'package:clima/reusable_card.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({this.locationWeather});

  final dynamic locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  WeatherModel weather = WeatherModel();
  int temperature, windSpeed, tempFeel, condition;
  String weatherIcon, cityName, weatherMessage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  Future<void> errorHandler(
      {Future<dynamic> method, String errorMessage}) async {
    setState(() async {
      try {
        final dynamic weatherData = await method;
        updateUI(weatherData);
      } on LocationServicesTurnedOff {
        _scaffoldKey.currentState.removeCurrentSnackBar();
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
            content: const Text(
              'Location is turned off',
            ),
            action: SnackBarAction(
              label: 'Turn on',
              onPressed: () async {
                await Geolocator.openLocationSettings();
              },
            ),
          ),
        );
      } on LocationPermissionDenied {
        _scaffoldKey.currentState.removeCurrentSnackBar();

        _scaffoldKey.currentState.showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
            content: Text('Permission denied'),
          ),
        );
      } on NoInternetConnection {
        _scaffoldKey.currentState.removeCurrentSnackBar();

        _scaffoldKey.currentState.showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
            content: Text('No network connection'),
          ),
        );
      } on DataIsNull {
        _scaffoldKey.currentState.removeCurrentSnackBar();

        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
            content: Text(errorMessage),
          ),
        );
      }
    });
  }

  /// This function updates the app ui with the weather data we got from the api

  void updateUI(dynamic weatherData) {
    setState(() {
      final double temp = (weatherData['main']['temp'] as num).toDouble();
      final double tempDoulbeFeel =
          (weatherData['main']['feels_like'] as num).toDouble();
      final double wind = (weatherData['wind']['speed'] as num).toDouble();
      temperature = temp.round();
      tempFeel = tempDoulbeFeel.round();
      windSpeed = (wind * 3.6).round();
      condition = (weatherData['weather'][0]['id'] as num).toInt();
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'] as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(cityName),
        leading: IconButton(
          tooltip: 'Refresh',
          icon: const Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          onPressed: () async {
            errorHandler(
                method: weather.getCityWeather(cityName),
                errorMessage: 'Connection error');
          },
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            onPressed: () async {
              final String typedName = await Navigator.push(
                context,
                MaterialPageRoute<String>(
                  builder: (BuildContext context) {
                    return CityScreen();
                  },
                ),
              );
              if (typedName != null) {
                errorHandler(
                    method: weather.getCityWeather(typedName),
                    errorMessage: 'Something went wrong');
              }
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            tooltip: "Get current geographic location's weather",
            onPressed: () async {
              errorHandler(
                  method: weather.getLocationWeather(),
                  errorMessage: "Can't connect to server");
            },
            icon: const Icon(
              Icons.location_on_outlined,
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
              ReusableCard(
                cardChild: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                              child: AutoSizeText(
                                '$temperature°',
                                style: kTempTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                              child: AutoSizeText(
                                weatherIcon,
                                style: kConditionTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: AutoSizeText(
                          'Feels like: $tempFeel°',
                          style: kMessageTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ReusableCard(
                cardChild: Center(
                  child: AutoSizeText(
                    'The 💨 speed is \n $windSpeed km/h',
                    style: kMessageTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ReusableCard(
                cardChild: Center(
                  child: AutoSizeText(
                    weatherMessage,
                    style: kMessageTextStyle,
                    textAlign: TextAlign.center,
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

/// flutter build apk --target-platform android-arm64 --split-per-abi
/// https://github.com/flutter/flutter/wiki/Upgrading-pre-1.12-Android-projects
