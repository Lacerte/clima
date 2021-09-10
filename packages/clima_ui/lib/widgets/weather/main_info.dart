import 'package:clima_ui/state_notifiers/weather_state_notifier.dart';
import 'package:clima_ui/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

class MainInfo extends HookWidget {
  const MainInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weather = useProvider(weatherStateNotifierProvider).weather;

    if (weather == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Text(
              weather.cityName.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 5,
                fontSize:
                    MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
                        ? 20.sp
                        : 14.sp,
                color: Theme.of(context).textTheme.subtitle1!.color,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Text(
              '${weather.temperature.round()}°',
              maxLines: 1,
              style: TextStyle(
                fontSize:
                    MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
                        ? 40.sp
                        : 30.sp,
                color: Theme.of(context).textTheme.subtitle1!.color,
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
                  size: MediaQuery.of(context).size.shortestSide <
                          kTabletBreakpoint
                      ? 11.sp
                      : 8.sp,
                  color: Theme.of(context).textTheme.subtitle1!.color,
                ),
                Text(
                  '${weather.maxTemperature.round()}°',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.shortestSide <
                            kTabletBreakpoint
                        ? 11.sp
                        : 8.sp,
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: MediaQuery.of(context).size.shortestSide <
                            kTabletBreakpoint
                        ? 11.sp
                        : 8.sp,
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                ),
                Text(
                  '${weather.minTemperature.round()}°',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.shortestSide <
                            kTabletBreakpoint
                        ? 11.sp
                        : 8.sp,
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                ),
              ],
            ),
          ),
          Text(
            weather.description.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w300,
              letterSpacing: 5,
              fontSize:
                  MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
                      ? 15.sp
                      : 10.sp,
              color: Theme.of(context).textTheme.subtitle1!.color,
            ),
          ),
        ],
      ),
    );
  }
}
