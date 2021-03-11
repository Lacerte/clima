import 'package:auto_size_text/auto_size_text.dart';
import 'package:clima_core/failure.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_domain/entities/weather.dart';
import 'package:clima_ui/main.dart';
import 'package:clima_ui/state_notifiers/city_state_notifier.dart' as c;
import 'package:clima_ui/state_notifiers/weather_state_notifier.dart' as w;
import 'package:clima_ui/utilities/constants.dart';
import 'package:clima_ui/utilities/hooks.dart';
import 'package:clima_ui/utilities/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:package_info/package_info.dart';

enum Menu { darkModeOn, licenses }

/// This function returns the right weather icon for the right condition.

IconData _getIconData(String iconCode) {
  switch (iconCode) {
    case '01d':
      return WeatherIcons.wiDaySunny;
    case '01n':
      return WeatherIcons.wiNightClear;
    case '02d':
      return WeatherIcons.wiDayCloudy;
    case '02n':
      return WeatherIcons.wiDayCloudy;
    case '03d':
    case '04d':
      return WeatherIcons.wiDayCloudyHigh;
    case '03n':
    case '04n':
      return WeatherIcons.wiNightClear;
    case '09d':
      return WeatherIcons.wiDayShowers;
    case '09n':
      return WeatherIcons.wiNightAltShowers;
    case '10d':
      return WeatherIcons.wiDayShowers;
    case '10n':
      return WeatherIcons.wiNightAltShowers;
    case '11d':
      return WeatherIcons.wiDayThunderstorm;
    case '11n':
      return WeatherIcons.wiNightThunderstorm;
    case '13d':
      return WeatherIcons.wiDaySnow;
    case '13n':
      return WeatherIcons.wiNightSnow;
    case '50d':
      return WeatherIcons.wiDayFog;
    case '50n':
      return WeatherIcons.wiNightFog;
    default:
      return WeatherIcons.wiDaySunny;
  }
}

class LocationScreen extends HookWidget {
  const LocationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeState = context.read(themeStateNotifier);

    final scaffoldKey = useGlobalKey<ScaffoldState>();

    final weatherState = useProvider(w.weatherStateNotifierProvider.state);

    final weatherStateNotifier = useProvider(w.weatherStateNotifierProvider);
    final controller = useFloatingSearchBarController();

    final isLoading = useState(weatherState is c.Loading);

    final cityStateNotifier = useProvider(c.cityStateNotifierProvider);

    void showFailureSnackbar(
        {@required Failure failure, VoidCallback onRetry, int duration}) {
      scaffoldKey.currentState.removeCurrentSnackBar();
      scaffoldKey.currentState.showSnackBar(
        failureSnackbar(
          failure: failure,
          onRetry: onRetry,
          duration: duration,
        ),
      );
    }

    Future<void> loadWeather() async {
      isLoading.value = true;
      await weatherStateNotifier.loadWeather();
      isLoading.value = false;
    }

    useEffect(
      () => cityStateNotifier.addListener((state) {
        if (state is c.Error) {
          showFailureSnackbar(failure: state.failure, duration: 2);
        }
      }),
      [cityStateNotifier],
    );

    useEffect(
      () => weatherStateNotifier.addListener((state) {
        if (state is w.Error) {
          showFailureSnackbar(
            failure: state.failure,
            onRetry: loadWeather,
          );
        }
      }),
      [weatherStateNotifier],
    );

    Weather weather;

    if (weatherState is w.Loaded) {
      weather = weatherState.weather;
    } else if (weatherState is w.Loading && weatherState.weather != null) {
      weather = weatherState.weather;
    } else if (weatherState is w.Error && weatherState.weather != null) {
      weather = weatherState.weather;
    } else {
      return Scaffold(key: scaffoldKey, body: const SizedBox.shrink());
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      body: FloatingSearchAppBar(
        automaticallyImplyBackButton: false,
        controller: controller,
        progress: isLoading.value,
        onSubmitted: (String newCityName) async {
          controller.close();

          final trimmedCityName = newCityName.trim();
          if (trimmedCityName.isEmpty) {
            return;
          }

          isLoading.value = true;
          await cityStateNotifier.setCity(City(name: trimmedCityName));
          if (context.read(c.cityStateNotifierProvider.state) is! c.Error) {
            await weatherStateNotifier.loadWeather();
          }
          isLoading.value = false;
        },
        title: Text(
          '${weather.cityName} (°C)',
          style: Theme.of(context).appBarTheme.textTheme.subtitle1,
        ),
        hint: 'Enter city name',
        color: _themeState.isDarkTheme ? Colors.black : const Color(0xFFF2F2F2),
        transitionCurve: Curves.easeInOut,
        leadingActions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircularButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: loadWeather,
            ),
          ),
          FloatingSearchBarAction.back(),
        ],
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircularButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {
                controller.open();
              },
            ),
          ),
          FloatingSearchBarAction(
            showIfOpened: false,
            child: PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              offset: const Offset(8.0, 8.0),
              icon: const Icon(Icons.more_vert),
              tooltip: 'More options',
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                PopupMenuItem<Menu>(
                  value: Menu.darkModeOn,
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return CheckboxListTile(
                        checkColor: _themeState.isDarkTheme
                            ? Colors.grey.shade900
                            : Colors.white,
                        title: const Text('Dark theme'),
                        value: _themeState.isDarkTheme,
                        onChanged: (bool value) {
                          setState(() {
                            value
                                ? _themeState.setDarkTheme()
                                : _themeState.setLightTheme();
                            Navigator.pop(context);
                          });
                        },
                      );
                    },
                  ),
                ),
                PopupMenuItem<Menu>(
                  value: Menu.licenses,
                  child: ListTile(
                    title: const Text('Licenses'),
                    onTap: () async {
                      final PackageInfo packageInfo =
                          await PackageInfo.fromPlatform();
                      showLicensePage(
                        context: context,
                        applicationName: packageInfo.appName,
                        applicationVersion: packageInfo.version,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          )
        ],
        body: Container(
          constraints: const BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                /// This card displays the temperature, the weather icon, and the weather description.
                ReusableWidgets(
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          /// Temperature.
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: AutoSizeText(
                                '${weather.temperature.round()}°',
                                style: kTempTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                          /// Weather icon.
                          Center(
                            //TODO: Fix alignment issues with Text and Icon
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Icon(
                                _getIconData(weather.iconCode),
                                size: 50.0,
                              ),
                            ),
                          ),
                        ],
                      ),

                      /// Weather description.
                      Center(
                        child: AutoSizeText(
                          '${weather.description[0].toUpperCase()}${weather.description.substring(1)}',
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
                          'It feels like ${weather.tempFeel.round()}°',
                          style: kMessageTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),

                      /// TempMax and TempMin.
                      Center(
                        child: AutoSizeText(
                          '↑${weather.maxTemperature.round()}°/↓${weather.minTemperature.round()}°',
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
                      // TODO: Weather Icon instead of an Emoji
                      //TODO: Add wind direction (icon)
                      'The 💨 speed is \n ${weather.windSpeed.round()} km/h',
                      style: kMessageTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
