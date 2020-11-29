import 'package:auto_size_text/auto_size_text.dart';
import 'package:clima/reusable_card.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  int temperature, windSpeed, tempFeel, condition, tempMax, tempMin;
  String weatherIcon, cityName, weatherMessage, description;
  bool visibility = false;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  Future<void> errorHandler({
    Future<dynamic> method,
    String errorMessage,
  }) async {
    try {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      final dynamic weatherData = await method;
      updateUI(weatherData);
      setState(() {
        visibility = false;
      });
    } on LocationServicesTurnedOff {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          content: const Text('Location is turned off.'),
          action: SnackBarAction(
            label: 'Turn on',
            onPressed: () async {
              await Geolocator.openLocationSettings();
            },
          ),
        ),
      );
      setState(() {
        visibility = false;
      });
    } on LocationPermissionDenied {
      _scaffoldKey.currentState.showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          content: Text('Permission denied.'),
        ),
      );
      setState(() {
        visibility = false;
      });
    } on NoInternetConnection {
      _scaffoldKey.currentState.showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          content: Text('No network connection.'),
        ),
      );
      setState(() {
        visibility = false;
      });
    } on DataIsNull {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          content: Text(errorMessage),
        ),
      );
      setState(() {
        visibility = false;
      });
    }
  }

  /// This function updates the app ui with the weather data we got from the api

  void updateUI(dynamic weatherData) {
    setState(() {
      final double temp = (weatherData['main']['temp'] as num).toDouble();
      final double tempFeelInDouble =
          (weatherData['main']['feels_like'] as num).toDouble();
      final double tempMaxInDouble =
          (weatherData['main']['temp_max'] as num).toDouble();
      final double tempMinInDouble =
          (weatherData['main']['temp_min'] as num).toDouble();
      final double wind = (weatherData['wind']['speed'] as num).toDouble();
      temperature = temp.round();
      tempMax = tempMaxInDouble.round();
      tempMin = tempMinInDouble.round();
      tempFeel = tempFeelInDouble.round();
      windSpeed = (wind * 3.6).round();
      condition = (weatherData['weather'][0]['id'] as num).toInt();
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'] as String;
      description = weatherData['weather'][0]['description'] as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('$cityName (°C)'),
        leading: IconButton(
          icon: const Icon(Icons.refresh),
          tooltip: 'Refresh',
          onPressed: () {
            setState(() {
              visibility = true;
            });
            errorHandler(
              method: weather.getCityWeather(cityName),
              errorMessage: "Can't connect to server.",
            );
          },
        ),
        actions: <Widget>[
          Visibility(
            visible: visibility,
            child: const Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
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
                setState(() {
                  visibility = true;
                });
                errorHandler(
                  method: weather.getCityWeather(typedName),
                  errorMessage: 'Something went wrong.',
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.location_on_outlined),
            tooltip: "Get current geographic location's weather",
            onPressed: () async {
              setState(() {
                visibility = true;
              });
              errorHandler(
                method: weather.getLocationWeather(),
                errorMessage: "Can't connect to server.",
              );
            },
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: AutoSizeText(
                              '$temperature°',
                              style: kTempTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: AutoSizeText(
                              weatherIcon,
                              style: kConditionTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: AutoSizeText(
                        '${description[0].toUpperCase()}${description.substring(1)}',
                        style: kMessageTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              ReusableCard(
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: AutoSizeText(
                        'It feels like $tempFeel°',
                        style: kMessageTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                     Center(
                       child: AutoSizeText(
                         '↑$tempMax°/↓$tempMin°',
                         style: kMessageTextStyle,
                         textAlign: TextAlign.center,
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
            ],
          ),
        ),
      ),
    );
  }
}

/// flutter build apk --target-platform android-arm64 --split-per-abi
/// https://github.com/flutter/flutter/wiki/Upgrading-pre-1.12-Android-projects
