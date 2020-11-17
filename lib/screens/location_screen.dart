import 'package:auto_size_text/auto_size_text.dart';
import 'package:clima/reusable_card.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  int temperature;
  int tempFeel;
  String sunrise;
  String sunset;
  int condition;
  String weatherIcon;
  String cityName;
  String weatherMessage;
  String middleContainerText;

  @override
  void initState() {
    super.initState();
    updateUI(
        widget.locationWeather, 'Connection error', 'No network connection');
  }

  // This function updates the app ui with the weather data we got from the api
  void updateUI(
      dynamic weatherData, String errorMessage, String networkErrorMessage) {
    setState(() {
      if (weatherData == null) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            //backgroundColor: Color(0xFF171717),
          ),
        );

        return;
      } else if (weatherData == 0) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              networkErrorMessage,
            ),
            //backgroundColor: Color(0xFF171717),
          ),
        );
      } else if (weatherData == 1) {
        _scaffoldKey.currentState.showSnackBar(
          const SnackBar(
            content: Text('Location is turned off'),
            //backgroundColor: Color(0xFF171717),
          ),
        );
      }
      final double temp = (weatherData['main']['temp'] as num).toDouble();
      temperature = temp.round();
      final double tempDoulbeFeel =
          (weatherData['main']['feels_like'] as num).toDouble();
      tempFeel = tempDoulbeFeel.round();

      condition = (weatherData['weather'][0]['id'] as num).toInt();
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'] as String;
      middleContainerText = 'Still to be determined';
      final int sr = (weatherData['sys']['sunrise'] as num).toInt();
      sunrise = timeConverter(sr);
      final int ss = (weatherData['sys']['sunset'] as num).toInt();
      sunset = timeConverter(ss);
    });
  }

  String timeConverter(int number) {
    final int secondsSinceEpoch = number;
    final int millisecondsSinceEpoch = secondsSinceEpoch * 1000;
    final DateTime result =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    return DateFormat.jm().format(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(cityName),
        //Refresh Button
        leading: IconButton(
          tooltip: 'Refresh',
          icon: const Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          onPressed: () async {
            final dynamic refreshedData =
                await weather.getCityWeather(cityName);
            updateUI(
                refreshedData, 'Connection error', 'No network connection');
          },
        ),
        actions: <Widget>[
          //Search Button
          IconButton(
            tooltip: 'Search',
            //padding: EdgeInsets.all(3),
            onPressed: () async {
              final String typedName = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return CityScreen();
                  },
                ),
              );
              if (typedName != null) {
                final dynamic weatherData =
                    await weather.getCityWeather(typedName);
                updateUI(weatherData, 'Something went wrong',
                    'No network connection');
              }
            },
            icon: const Icon(
              Icons.search,

              // size: 40.0,
            ),
          ),
          // Get current geo location button
          IconButton(
            tooltip: 'Get current geo location',
            //padding: EdgeInsets.all(3),
            onPressed: () async {
              final dynamic currentWeatherData =
                  await weather.getLocationWeather();
              if (currentWeatherData == 3) {
                updateUI(1, "Can't connect to server", 'No network connection');
              } else if (currentWeatherData == null) {
                updateUI(currentWeatherData, "Can't connect to server",
                    'No network connection');
              } else {
                updateUI(currentWeatherData, "Can't connect to server",
                    'No network connection');
              }
            },
            icon: const Icon(
              Icons.location_on_outlined,
              //size: 40.0,
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
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                              child: AutoSizeText(
                                '$temperature°',
                                style: kTempTextStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                              child: AutoSizeText(
                                weatherIcon,
                                style: kConditionTextStyle,
                              ),
                            ),
                          ],
                        ),
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
                cardChild: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: MainAxisAlignment.space,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: AutoSizeText(
                          'Sunrise: $sunrise',
                          style: kMessageTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: AutoSizeText(
                          'Sunset: $sunset',
                          style: kMessageTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ReusableCard(
                cardChild: AutoSizeText(
                  '$weatherMessage.',
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
