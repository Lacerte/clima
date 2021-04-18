import 'package:clima_core/failure.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_ui/main.dart';
import 'package:clima_ui/state_notifiers/city_state_notifier.dart' as c;
import 'package:clima_ui/state_notifiers/forecasts_state_notifier.dart' as f;
import 'package:clima_ui/state_notifiers/weather_state_notifier.dart' as w;
import 'package:clima_ui/utilities/hooks.dart';
import 'package:clima_ui/utilities/reusable_widgets.dart';
import 'package:clima_ui/widgets/current_conditions_widgets.dart';
import 'package:clima_ui/widgets/forecast_widget.dart';
import 'package:clima_ui/widgets/value_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:package_info/package_info.dart';
import 'package:riverpod/riverpod.dart';

enum Menu { darkModeOn, licenses }

class LocationScreen extends HookWidget {
  const LocationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeState = context.read(themeStateNotifier);

    final scaffoldKey = useGlobalKey<ScaffoldState>();

    final weatherState = useProvider(w.weatherStateNotifierProvider.state);

    final forecastsStateNotifier =
        useProvider(f.forecastsStateNotifierProvider);

    final weatherStateNotifier = useProvider(w.weatherStateNotifierProvider);
    final controller = useFloatingSearchBarController();

    final isLoading = useState(weatherState is c.Loading);

    final cityStateNotifier = useProvider(c.cityStateNotifierProvider);

    final weather = useProvider(w.weatherStateNotifierProvider.state).weather;

    void showFailureSnackBar(
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

    Future<void> load() async {
      isLoading.value = true;
      await Future.wait(
        [
          weatherStateNotifier.loadWeather(),
          forecastsStateNotifier.loadForecasts(),
        ],
      );
      isLoading.value = false;
    }

    useEffect(
      () => cityStateNotifier.addListener((state) {
        if (state is c.Error) {
          showFailureSnackBar(failure: state.failure, duration: 2);
        }
      }),
      [cityStateNotifier],
    );

    useEffect(
      () => weatherStateNotifier.addListener((state) {
        if (state is w.Error) {
          showFailureSnackBar(
            failure: state.failure,
            onRetry: load,
          );
        }
      }),
      [weatherStateNotifier],
    );

    useEffect(
      () => forecastsStateNotifier.addListener((state) {
        if (state is f.Error) {
          showFailureSnackBar(
            failure: state.failure,
            onRetry: load,
          );
        }
      }),
      [forecastsStateNotifier],
    );

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
            await Future.wait([
              weatherStateNotifier.loadWeather(),
              forecastsStateNotifier.loadForecasts(),
            ]);
          }
          isLoading.value = false;
        },
        title: Text(
          DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
          style: TextStyle(
            color: Theme.of(context).textTheme.subtitle1.color.withAlpha(130),
            fontSize: 14,
          ),
        ),
        hint: 'Enter city name',
        color: _themeState.isDarkTheme ? Colors.black : const Color(0xFFF2F2F2),
        transitionCurve: Curves.easeInOut,
        leadingActions: [
          FloatingSearchBarAction(
            child: CircularButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: load,
            ),
          ),
          FloatingSearchBarAction.back(),
        ],
        actions: [
          FloatingSearchBarAction(
            child: CircularButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {
                controller.open();
              },
            ),
          ),
          FloatingSearchBarAction(
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
        body: () {
          if (weather == null) {
            return const SizedBox.shrink();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        weather.cityName.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 5,
                          color: Theme.of(context).textTheme.subtitle1.color,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Text(
                      weather.description.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        letterSpacing: 5,
                        fontSize: 15,
                        color: Theme.of(context).textTheme.subtitle1.color,
                      ),
                    ),
                    const CurrentConditions(),
                  ],
                ),
              ),
              Divider(
                color:
                    Theme.of(context).textTheme.subtitle1.color.withAlpha(65),
              ),
              Flexible(
                flex: 2,
                child: ForecastHorizontal(),
              ),
              Divider(
                color:
                    Theme.of(context).textTheme.subtitle1.color.withAlpha(65),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ValueTile(
                          'wind speed', '${weather.windSpeed.round()} m/s'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: Container(
                            width: 1,
                            height: 35,
                            color: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .color
                                .withAlpha(65),
                          ),
                        ),
                      ),
                      ValueTile(
                        'sunrise',
                        DateFormat('h:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            weather.sunrise * 1000,
                          ).toUtc().add(
                                weather.timeZoneOffset,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: Container(
                            width: 1,
                            height: 35,
                            color: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .color
                                .withAlpha(65),
                          ),
                        ),
                      ),
                      ValueTile(
                        'sunset',
                        DateFormat('h:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch(
                                  weather.sunset * 1000)
                              .toUtc()
                              .add(weather.timeZoneOffset),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: Container(
                            width: 1,
                            height: 35,
                            color: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .color
                                .withAlpha(65),
                          ),
                        ),
                      ),
                      ValueTile('humidity', '${weather.humidity}%'),
                    ],
                  ),
                ),
              ),
            ],
          );
        }(),
      ),
    );
  }
}
