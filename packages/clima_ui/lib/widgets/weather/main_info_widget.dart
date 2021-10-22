import 'package:clima_ui/state_notifiers/full_weather_state_notifier.dart' as w;
import 'package:clima_ui/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

class MainInfoWidget extends HookWidget {
  const MainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentWeather = useProvider(
      w.fullWeatherStateNotifierProvider.select(
        (state) => state.fullWeather!.currentWeather,
      ),
    );
    final currentDayForecast = useProvider(
      w.fullWeatherStateNotifierProvider.select(
        (state) => state.fullWeather!.currentDayForecast,
      ),
    );
    final city = useProvider(
      w.fullWeatherStateNotifierProvider.select(
        (state) => state.fullWeather!.city,
      ),
    );
    return Padding(
      padding: EdgeInsets.only(
        top: () {
          if (MediaQuery.of(context).size.shortestSide < kTabletBreakpoint) {
            if (MediaQuery.of(context).orientation == Orientation.landscape) {
              return 0.0;
            } else {
              return 4.h;
            }
          } else {
            return 8.h;
          }
        }(),
        bottom: 4.h,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Text(
              city.name.toUpperCase(),
              style: kSubtitle1TextStyle(context).copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 5,
                fontSize:
                    MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
                        ? 20.sp
                        : 14.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Text(
              '${currentWeather.temperature.round()}°',
              maxLines: 1,
              style: kSubtitle1TextStyle(context).copyWith(
                fontSize:
                    MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
                        ? 40.sp
                        : 30.sp,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.keyboard_arrow_up,
                  size: kIconSize(context),
                  color: Theme.of(context).textTheme.subtitle1!.color,
                ),
                Text(
                  '${currentDayForecast.maxTemperature.round()}°',
                  style: kSubtitle1TextStyle(context),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: kIconSize(context),
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                ),
                Text(
                  '${currentDayForecast.minTemperature.round()}°',
                  style: kSubtitle1TextStyle(context),
                ),
              ],
            ),
          ),
          Text(
            currentWeather.description.toUpperCase(),
            style: kSubtitle1TextStyle(context).copyWith(
              fontWeight: FontWeight.w300,
              letterSpacing: 5,
              fontSize:
                  MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
                      ? 15.sp
                      : 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
