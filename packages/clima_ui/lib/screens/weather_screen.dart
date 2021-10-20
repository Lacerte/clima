import 'package:clima_domain/entities/city.dart';
import 'package:clima_ui/state_notifiers/city_state_notifier.dart' as c;
import 'package:clima_ui/state_notifiers/full_weather_state_notifier.dart' as w;
import 'package:clima_ui/utilities/constants.dart';
import 'package:clima_ui/utilities/failure_snack_bar.dart';
import 'package:clima_ui/utilities/hooks.dart';
import 'package:clima_ui/widgets/others/overflow_menu_button.dart';
import 'package:clima_ui/widgets/weather/additional_info_widget.dart';
import 'package:clima_ui/widgets/weather/daily_forecasts_widget.dart';
import 'package:clima_ui/widgets/weather/hourly_forecasts_widget.dart';
import 'package:clima_ui/widgets/weather/main_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:sizer/sizer.dart';

class WeatherScreen extends HookWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullWeatherState = useProvider(w.fullWeatherStateNotifierProvider);

    final fullWeatherStateNotifier =
        useProvider(w.fullWeatherStateNotifierProvider.notifier);
    final controller = useFloatingSearchBarController();

    final isLoading = useState(fullWeatherState is c.Loading);

    final cityStateNotifier = useProvider(c.cityStateNotifierProvider.notifier);

    Future<void> load() async {
      await fullWeatherStateNotifier.loadFullWeather();
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
      () => fullWeatherStateNotifier.addListener((state) {
        if (state is w.Error) {
          showFailureSnackBar(context, failure: state.failure, duration: 2);
        }
      }),
      [fullWeatherStateNotifier],
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FloatingSearchAppBar(
        liftOnScrollElevation: 0.0,
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
        automaticallyImplyBackButton: false,
        controller: controller,
        progress: isLoading.value,
        accentColor: Theme.of(context).colorScheme.secondary,
        onSubmitted: (String newCityName) async {
          controller.close();

          final trimmedCityName = newCityName.trim();
          if (trimmedCityName.isEmpty) {
            return;
          }

          isLoading.value = true;
          await cityStateNotifier.setCity(City(name: trimmedCityName));
          if (context.read(c.cityStateNotifierProvider) is! c.Error) {
            await load();
          }
          isLoading.value = false;
        },
        title: Text(
          'Updated ${DateFormat.Md().add_jm().format(DateTime.now())}',
          style: TextStyle(
            color: Theme.of(context).textTheme.subtitle2!.color,
            fontSize:
                MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
                    ? 11.sp
                    : 5.sp,
          ),
        ),
        hint: 'Enter city name',
        color: Theme.of(context).appBarTheme.backgroundColor,
        transitionCurve: Curves.easeInOut,
        leadingActions: [
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
          const FloatingSearchBarAction(
            child: OverflowMenuButton(),
          ),
          FloatingSearchBarAction.searchToClear(
            color: Theme.of(context).appBarTheme.iconTheme!.color,
            showIfClosed: false,
          )
        ],
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: load,
            color: Theme.of(context).textTheme.subtitle1!.color,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: () {
                  if (MediaQuery.of(context).orientation ==
                          Orientation.landscape &&
                      MediaQuery.of(context).size.shortestSide >
                          kTabletBreakpoint) {
                    return 10.0.w;
                  } else if (MediaQuery.of(context).orientation ==
                          Orientation.landscape &&
                      MediaQuery.of(context).size.shortestSide <
                          kTabletBreakpoint) {
                    return 35.0.w;
                  } else {
                    return 5.0.w;
                  }
                }(),
              ),
              child: Container(
                constraints: const BoxConstraints.expand(),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const MainInfoWidget(),
                      Divider(
                        color: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .color!
                            .withAlpha(65),
                      ),
                      SizedBox(
                        height: 16.h,
                        child: const HourlyForecastsWidget(),
                      ),
                      Divider(
                        color: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .color!
                            .withAlpha(65),
                      ),
                      const DailyForecastsWidget(),
                      Divider(
                        color: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .color!
                            .withAlpha(65),
                      ),
                      const AdditionalInfoWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
