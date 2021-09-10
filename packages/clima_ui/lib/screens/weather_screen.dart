import 'package:clima_domain/entities/city.dart';
import 'package:clima_ui/screens/settings_screen.dart';
import 'package:clima_ui/state_notifiers/city_state_notifier.dart' as c;
import 'package:clima_ui/state_notifiers/forecasts_state_notifier.dart' as f;
import 'package:clima_ui/state_notifiers/weather_state_notifier.dart' as w;
import 'package:clima_ui/utilities/failure_snack_bar.dart';
import 'package:clima_ui/utilities/hooks.dart';
import 'package:clima_ui/utilities/modal_buttom_sheet.dart';
import 'package:clima_ui/widgets/settings/settings_tile.dart';
import 'package:clima_ui/widgets/weather/day_tile.dart';
import 'package:clima_ui/widgets/weather/hourly_forecast.dart';
import 'package:clima_ui/widgets/weather/main_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

enum Menu { settings, help }

class WeatherScreen extends HookWidget {
  const WeatherScreen({Key? key}) : super(key: key);

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
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
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
        title: const Text(''),
        hint: 'Enter city name',
        color: Theme.of(context).appBarTheme.color,
        transitionCurve: Curves.easeInOut,
        leadingActions: [
          FloatingSearchBarAction(
            child: CircularButton(
              icon: Icon(
                Icons.refresh,
                color: Theme.of(context).appBarTheme.iconTheme!.color,
              ),
              tooltip: 'Refresh',
              onPressed: load,
            ),
          ),
          FloatingSearchBarAction.back(
            color: Theme.of(context).appBarTheme.iconTheme!.color,
          ),
        ],
        actions: [
          FloatingSearchBarAction(
            child: CircularButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).appBarTheme.iconTheme!.color,
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
              offset: const Offset(512.0, -512.0),
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).appBarTheme.iconTheme!.color,
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
                                'https://github.com/lacerte/clima/issues/new',
                              ),
                            ),
                            SettingsTile(
                              title: 'Contact developer',
                              leading: Icon(
                                Icons.email_outlined,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              onTap: () => launch(
                                'mailto:lacerte@protonmail.com',
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
            color: Theme.of(context).appBarTheme.iconTheme!.color,
            showIfClosed: false,
          )
        ],
        body: SingleChildScrollView(
          child: Column(
            children: [
              const MainInfo(),
              Divider(
                color:
                    Theme.of(context).textTheme.subtitle1!.color!.withAlpha(65),
              ),
              SizedBox(
                height: 16.h,
                child: HourlyForecast(),
              ),
              Divider(
                color:
                    Theme.of(context).textTheme.subtitle1!.color!.withAlpha(65),
              ),
              DayTile(),
            ],
          ),
        ),
      ),
    );
  }
}
