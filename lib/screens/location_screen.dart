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
  String weatherIcon, cityName, description;
  bool visibility = false;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  /// This function handles all the errors that might get thrown from the services file. If there are no errors, the work is passed to updateUI.
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
      setState(() {
        visibility = false;
      });
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
    } on LocationPermissionDenied {
      setState(() {
        visibility = false;
      });
      _scaffoldKey.currentState.showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          content: Text('Permission denied.'),
        ),
      );
    } on NoInternetConnection {
      setState(() {
        visibility = false;
      });
      _scaffoldKey.currentState.showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          content: Text('No network connection.'),
        ),
      );
    } on DataIsNull {
      setState(() {
        visibility = false;
      });
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          content: Text(errorMessage),
        ),
      );
    }
  }

  /// This function updates the app ui with the weather data we got from the api.

  void updateUI(dynamic weatherData) {
    setState(() {
      final double wind = (weatherData['wind']['speed'] as num).toDouble();
      temperature = (weatherData['main']['temp'] as num).round();
      tempMax = (weatherData['main']['temp_max'] as num).round();
      tempMin = (weatherData['main']['temp_min'] as num).round();
      tempFeel = (weatherData['main']['feels_like'] as num).round();
      windSpeed = (wind * 3.6).round();
      condition = (weatherData['weather'][0]['id'] as num).toInt();
      weatherIcon = weather.getWeatherIcon(condition);
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
          /// The loading indicator widget.
          Visibility(
            visible: visibility,
            child: const Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 1.5),
              ),
            ),
          ),

          /// The search button.
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

          /// The get current geographic location's weather button.
          IconButton(
            icon: const Icon(Icons.location_on_outlined),
            tooltip: "Get current geographic location's weather",
            onPressed: () {
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
              /// This card displays the temperature, the weather icon, and the weather description.
              ReusableCard(
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        /// Temperature.
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

                        /// Weather icon.
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

                    /// Weather description.
                    Center(
                      child: AutoSizeText(
                        '${description[0].toUpperCase()}${description.substring(1)}',
                        maxLines: 1,
                        presetFontSizes: const <double>[30, 20, 10],
                        style: kMessageTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              /// This card displays tempFeel, tempMax, and tempMin.
              ReusableCard(
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /// TempFeel.
                    Center(
                      child: AutoSizeText(
                        'It feels like $tempFeel°',
                        style: kMessageTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    /// TempMax and TempMin.
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

              /// This card displays the wind speed.
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
