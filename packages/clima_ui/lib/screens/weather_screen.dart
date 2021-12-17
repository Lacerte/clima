/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_domain/entities/city.dart';
import 'package:clima_ui/state_notifiers/city_state_notifier.dart' as c;
import 'package:clima_ui/state_notifiers/full_weather_state_notifier.dart' as w;
import 'package:clima_ui/utilities/constants.dart';
import 'package:clima_ui/utilities/failure_snack_bar.dart';
import 'package:clima_ui/utilities/hooks.dart';
import 'package:clima_ui/widgets/others/failure_banner.dart';
import 'package:clima_ui/widgets/others/overflow_menu_button.dart';
import 'package:clima_ui/widgets/weather/additional_info_widget.dart';
import 'package:clima_ui/widgets/weather/daily_forecasts_widget.dart';
import 'package:clima_ui/widgets/weather/hourly_forecasts_widget.dart';
import 'package:clima_ui/widgets/weather/main_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:sizer/sizer.dart';

class WeatherScreen extends HookConsumerWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fullWeatherState = ref.watch(w.fullWeatherStateNotifierProvider);

    final fullWeatherStateNotifier =
        ref.watch(w.fullWeatherStateNotifierProvider.notifier);

    final controller = useFloatingSearchBarController();

    final cityStateNotifier = ref.watch(c.cityStateNotifierProvider.notifier);
    final cityState = ref.watch(c.cityStateNotifierProvider);

    final refreshIndicatorKey = useGlobalKey<RefreshIndicatorState>();

    useEffect(
      () {
        Future.microtask(() => fullWeatherStateNotifier.loadFullWeather());
        return null;
      },
      [fullWeatherStateNotifier],
    );

    useEffect(
      () {
        if (fullWeatherState.fullWeather == null) {
          return null;
        }
        return cityStateNotifier.addListener((state) {
          if (state is c.Error) {
            showFailureSnackBar(context, failure: state.failure, duration: 2);
          }
        });
      },
      [cityStateNotifier, fullWeatherState.fullWeather],
    );

    useEffect(
      () {
        if (fullWeatherState.fullWeather == null) {
          return null;
        }
        return fullWeatherStateNotifier.addListener((state) {
          if (state is w.Error) {
            showFailureSnackBar(context, failure: state.failure, duration: 2);
          }
        });
      },
      [fullWeatherStateNotifier, fullWeatherState.fullWeather],
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FloatingSearchAppBar(
        liftOnScrollElevation: 0.0,
        elevation: fullWeatherState.fullWeather == null ? 2.0 : 0.0,
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
        automaticallyImplyBackButton: false,
        controller: controller,
        progress: fullWeatherState is w.Loading || cityState is c.Loading,
        accentColor: Theme.of(context).colorScheme.secondary,
        onSubmitted: (String newCityName) async {
          controller.close();

          final trimmedCityName = newCityName.trim();
          if (trimmedCityName.isEmpty) {
            return;
          }

          await cityStateNotifier.setCity(City(name: trimmedCityName));
          if (ref.read(c.cityStateNotifierProvider) is! c.Error) {
            await fullWeatherStateNotifier.loadFullWeather();
          }
        },
        title: Text(
          fullWeatherState.fullWeather == null
              ? ''
              : 'Updated ${DateFormat.Md().add_jm().format(DateTime.now())}',
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
          const FloatingSearchBarAction(child: OverflowMenuButton()),
          FloatingSearchBarAction.searchToClear(
            color: Theme.of(context).appBarTheme.iconTheme!.color,
            showIfClosed: false,
          )
        ],
        body: SafeArea(
          child: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: fullWeatherStateNotifier.loadFullWeather,
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
              child: fullWeatherState is w.Error &&
                      fullWeatherState.fullWeather == null
                  ? FailureBanner(
                      failure: fullWeatherState.failure,
                      onRetry: fullWeatherStateNotifier.loadFullWeather,
                    )
                  : fullWeatherState.fullWeather == null
                      ? null
                      : Container(
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
                                  height:
                                      MediaQuery.of(context).size.aspectRatio ==
                                              1.0
                                          ? 24.h
                                          : 16.h,
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
