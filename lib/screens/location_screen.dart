import 'package:auto_size_text/auto_size_text.dart';
import 'package:clima/main.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/themes/theme_model.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/utilities/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'city_screen.dart';

enum Menu { darkModeOn }

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
  bool isVisible = false;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  /// This function handles all the errors that might get thrown from the services file. If there are no errors, the work is passed to updateUI.
  Future<void> errorHandler({
    Future<dynamic> future,
    String errorMessage,
  }) async {
    try {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      final dynamic weatherData = await future;
      updateUI(weatherData);
    } on NoInternetConnection {
      _scaffoldKey.currentState.showSnackBar(
        await snackBar(text: 'No network connection.'),
      );
    } on DataIsNull {
      _scaffoldKey.currentState.showSnackBar(
        await snackBar(text: errorMessage),
      );
    } finally {
      setState(() {
        isVisible = false;
      });
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
    saveCityName(cityName);
  }

  /// This function save the city name to shared preferences
  Future<void> saveCityName(String city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', city);
  }

  @override
  Widget build(BuildContext context) {
    final _themeState = context.read(themeStateNotifier);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          '$cityName (°C)',
          style: Theme.of(context).appBarTheme.textTheme.subtitle1,
        ),
        leading: IconButton(
          color: Theme.of(context).appBarTheme.actionsIconTheme.color,
          icon: const Icon(Icons.refresh),
          tooltip: 'Refresh',
          onPressed: () {
            setState(() {
              isVisible = true;
            });
            errorHandler(
              future: weather.getCityWeather(cityName),
              errorMessage: "Can't connect to server.",
            );
          },
        ),
        actions: <Widget>[
          /// The loading indicator widget.
          Visibility(
            visible: isVisible,
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
                  isVisible = true;
                });
                errorHandler(
                  future: weather.getCityWeather(typedName),
                  errorMessage: 'Something went wrong.',
                );
              }
            },
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            tooltip: 'More options',
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              PopupMenuItem<Menu>(
                value: Menu.darkModeOn,
                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return CheckboxListTile(
                    checkColor: ThemeModel().checkMarkColor(_themeState),
                    title: const Text('Dark theme'),
                    value: _isDarkMode,
                    onChanged: (bool value) {
                      setState(() {
                        value
                            ? _themeState.setBlackTheme()
                            : _themeState.setLightTheme();
                        _isDarkMode = value;
                        Navigator.pop(context);
                      });
                    },
                  );
                }),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /// This card displays the temperature, the weather icon, and the weather description.
              ReusableWidgets(
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
                        presetFontSizes: const <double>[30, 25, 20, 15, 10],
                        style: kMessageTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              /// This card displays tempFeel, tempMax, and tempMin.
              ReusableWidgets(
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
              ReusableWidgets(
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
