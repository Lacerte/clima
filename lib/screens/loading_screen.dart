import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  Future<void> getLocationData() async {
    final dynamic weatherData = await WeatherModel().getCityWeather('Riyadh');
    if (weatherData == null || weatherData == 0 || weatherData == 1) {
      setState(() {
        if (weatherData == null) {
          _scaffoldKey.currentState.showSnackBar(
            const SnackBar(
              content: Text("Can't connect to server"),
              //backgroundColor: Color(0xFF171717),
            ),
          );

          return;
        } else if (weatherData == 0) {
          _scaffoldKey.currentState.showSnackBar(
            const SnackBar(
              content: Text(
                'No network connection',
              ),
              //backgroundColor: Color(0xFF171717),
            ),
          );
        }
      });
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return LocationScreen(
          locationWeather: weatherData,
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
