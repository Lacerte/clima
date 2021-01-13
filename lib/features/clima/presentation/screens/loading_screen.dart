import 'dart:math';

import 'package:clima/features/clima/presentation/screens/location_screen.dart';
import 'package:clima/features/clima/presentation/services/networking.dart';
import 'package:clima/features/clima/presentation/services/weather.dart';
import 'package:clima/features/clima/presentation/utilities/reusable_widgets.dart';
import 'package:clima/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> randomCityNames = <String>[
    'Amsterdam',
    'London',
    'Paris',
    'New York',
    'Las Vegas',
    'Texas',
    'Ohio',
    'Riyadh',
    'Dubai',
    'Istanbul',
    'Berlin',
    'Tokyo',
    'Doha',
    'Venice',
    'Sydney',
  ];

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  /// This function gets the saved city name from shared preferences
  Future<String> getSavedCityName() async {
    final String getRandomCityName =
        randomCityNames[Random().nextInt(randomCityNames.length)];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name');
    if (name == null) {
      return name = getRandomCityName;
    }
    return name;
  }

  /// This function tries to get the weatherData from weather.dart and pass it to the location_screen.
  Future<void> getLocationData() async {
    final String savedName = await getSavedCityName();
    try {
      final dynamic weatherData =
          await WeatherModel().getCityWeather(savedName);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) {
            return LocationScreen(locationWeather: weatherData);
          },
        ),
      );
    } on NoInternetConnection {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(
        await snackBar(
          text: 'No network connection',
          duration: 86400,
          action: SnackBarAction(
            label: 'Retry',
            onPressed: () async {
              await getLocationData();
            },
          ),
        ),
      );
    } on DataIsNull {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(
        await snackBar(
          text: "Can't connect to server",
          duration: 86400,
          action: SnackBarAction(
            label: 'Retry',
            onPressed: () async {
              await getLocationData();
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _themeState = context.read(themeStateNotifier);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SpinKitDoubleBounce(
          color: _themeState.isDarkTheme ? Colors.white : Colors.black,
          size: 100.0,
        ),
      ),
    );
  }
}
