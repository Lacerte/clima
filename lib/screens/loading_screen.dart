import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

  // bool isDone = false;
  // dynamic weatherDataFinal;
  Future<void> getLocationData() async {
    final dynamic weatherData = await WeatherModel().getCityWeather('Riyadh');
    if (weatherData == null || weatherData == 0 || weatherData == 1) {
      setState(() {
        if (weatherData == null) {
          //ScaffoldState().removeCurrentSnackBar;
          _scaffoldKey.currentState.removeCurrentSnackBar();
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              backgroundColor: Colors.grey[600],
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
              content: Text("Can't connect to server"),
              //backgroundColor: Color(0xFF171717),
            ),
          );

          //return;
        } else if (weatherData == 0) {
          _scaffoldKey.currentState.removeCurrentSnackBar();
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              backgroundColor: Colors.grey[600],
              behavior: SnackBarBehavior.floating,
              duration: Duration(hours: 24),
              content: Text(
                'No network connection',
              ),
              action: SnackBarAction(
                label: 'Retry',
                onPressed: () async {
                  await getLocationData();
                },
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

  // isDoneAction() {
  //   if (isDone) {
  //     return LocationScreen(
  //       locationWeather: weatherDataFinal,
  //     );
  //   } else {
  //     return LoadingScreen();
  //   }
  // }

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
