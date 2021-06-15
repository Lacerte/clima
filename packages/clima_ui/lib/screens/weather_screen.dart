import 'package:clima_domain/entities/city.dart';
import 'package:clima_ui/screens/settings_screen.dart';
import 'package:clima_ui/state_notifiers/city_state_notifier.dart' as c;
import 'package:clima_ui/state_notifiers/forecasts_state_notifier.dart' as f;
import 'package:clima_ui/state_notifiers/weather_state_notifier.dart' as w;
import 'package:clima_ui/utilities/failure_snack_bar.dart';
import 'package:clima_ui/utilities/hooks.dart';
import 'package:clima_ui/widgets/reusable_widgets.dart';
import 'package:clima_ui/widgets/weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:url_launcher/url_launcher.dart';

enum Menu { settings, help }

class LocationScreen extends HookWidget {
  const LocationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherState = useProvider(w.weatherStateNotifierProvider);

    final forecastsStateNotifier =
        useProvider(f.forecastsStateNotifierProvider.notifier);

    final weatherStateNotifier =
        useProvider(w.weatherStateNotifierProvider.notifier);
    final controller = useFloatingSearchBarController();

    final isLoading = useState(weatherState is c.Loading);

    final cityStateNotifier = useProvider(c.cityStateNotifierProvider.notifier);

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
          showFailureSnackBar(context, failure: state.failure, duration: 2);
        }
      }),
      [cityStateNotifier],
    );

    useEffect(
      () => weatherStateNotifier.addListener((state) {
        if (state is w.Error) {
          showFailureSnackBar(context, failure: state.failure, duration: 2);
        }
      }),
      [weatherStateNotifier],
    );

    useEffect(
      () => forecastsStateNotifier.addListener((state) {
        if (state is f.Error) {
          showFailureSnackBar(context, failure: state.failure, duration: 2);
        }
      }),
      [forecastsStateNotifier],
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            color: Theme.of(context).textTheme.subtitle2.color,
            fontSize: 14,
          ),
        ),
        hint: 'Enter city name',
        color: Theme.of(context).appBarTheme.color,
        transitionCurve: Curves.easeInOut,
        leadingActions: [
          FloatingSearchBarAction(
            child: CircularButton(
              icon: Icon(
                Icons.refresh,
                color: Theme.of(context).appBarTheme.iconTheme.color,
              ),
              tooltip: 'Refresh',
              onPressed: load,
            ),
          ),
          FloatingSearchBarAction.back(
            color: Theme.of(context).appBarTheme.iconTheme.color,
          ),
        ],
        actions: [
          FloatingSearchBarAction(
            child: CircularButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).appBarTheme.iconTheme.color,
              ),
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
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).appBarTheme.iconTheme.color,
              ),
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
                          children: [
                            SettingsTile(
                              title: 'Submit issue',
                              leading: Icon(
                                Icons.bug_report_outlined,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              onTap: () => launch(
                                'https://github.com/CentaurusApps/clima/issues/new',
                              ),
                            ),
                            SettingsTile(
                              title: 'Contact developer',
                              leading: Icon(
                                Icons.email_outlined,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              onTap: () => launch(
                                'mailto:apps_centaurus@protonmail.com',
                              ),
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
            color: Theme.of(context).appBarTheme.iconTheme.color,
            showIfClosed: false,
          )
        ],
        body: const WeatherWidget(),
      ),
    );
  }
}
