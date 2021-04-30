import 'package:clima_core/failure.dart';
import 'package:clima_domain/entities/city.dart';
import 'package:clima_ui/main.dart';
import 'package:clima_ui/screens/settings_screen.dart';
import 'package:clima_ui/state_notifiers/city_state_notifier.dart' as c;
import 'package:clima_ui/state_notifiers/forecasts_state_notifier.dart' as f;
import 'package:clima_ui/state_notifiers/weather_state_notifier.dart' as w;
import 'package:clima_ui/utilities/hooks.dart';
import 'package:clima_ui/utilities/reusable_widgets.dart';
import 'package:clima_ui/widgets/reusable_widgets.dart';
import 'package:clima_ui/widgets/weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

enum Menu { settings, help }

class LocationScreen extends HookWidget {
  const LocationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeState = context.read(themeStateNotifier);

    final scaffoldKey = useGlobalKey<ScaffoldState>();

    final weatherState = useProvider(w.weatherStateNotifierProvider);

    final forecastsStateNotifier =
        useProvider(f.forecastsStateNotifierProvider.notifier);

    final weatherStateNotifier =
        useProvider(w.weatherStateNotifierProvider.notifier);
    final controller = useFloatingSearchBarController();

    final isLoading = useState(weatherState is c.Loading);

    final cityStateNotifier = useProvider(c.cityStateNotifierProvider.notifier);

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
          if (context.read(c.cityStateNotifierProvider) is! c.Error) {
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
                  value: Menu.settings,
                  child: ListTile(
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SettingScreen(),
                        ),
                      );
                    },
                  ),
                ),
                PopupMenuItem<Menu>(
                  value: Menu.help,
                  child: ListTile(
                    title: const Text('Help & feedback'),
                    onTap: () {
                      Navigator.of(context).pop();
                      showGeneralSheet(
                        context,
                        title: 'Help & feedback',
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            SettingsTile(
                              icon: Icon(Icons.bug_report_outlined),
                              title: 'Submit issue',
                            ),
                            SettingsTile(
                              icon: Icon(Icons.email_outlined),
                              title: 'Contact developer',
                            ),
                          ],
                        ),
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
        body: const WeatherWidget(),
      ),
    );
  }
}
