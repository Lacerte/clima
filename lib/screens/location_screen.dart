import 'package:clima/reusable_card.dart';
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
  String middleContainerText;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  // This function updates the app ui with the weather data we got from the api
  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        middleContainerText = 'Turn Location on';
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
      middleContainerText = 'Still to be determined';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            final refreshedData = await weather.getCityWeather(cityName);
            updateUI(refreshedData);
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
          // Get current geo location button
          IconButton(
            tooltip: 'Get current geo location',
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
                cardChild: Row(
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
              ReusableCard(
                cardChild: Text(
                  middleContainerText,
                  style: kMessageTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              ReusableCard(
                cardChild: Text(
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
