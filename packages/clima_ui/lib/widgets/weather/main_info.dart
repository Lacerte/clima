import 'package:auto_size_text/auto_size_text.dart';
import 'package:clima_ui/state_notifiers/weather_state_notifier.dart';
import 'package:clima_ui/utilities/constants.dart';
import 'package:clima_ui/utilities/weather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      padding: EdgeInsets.only(left: 32.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                weather.cityName,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.shortestSide <
                          kTabletBreakpoint
                      ? 20.sp
                      : 14.sp,
                  color: Theme.of(context).textTheme.subtitle1!.color,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    '${weather.temperature.round()}°',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.shortestSide <
                              kTabletBreakpoint
                          ? 40.sp
                          : 30.sp,
                      color: Theme.of(context).textTheme.subtitle1!.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: FaIcon(
                    getIconData(weather.iconCode),
                    color: Theme.of(context).iconTheme.color,
                    size: MediaQuery.of(context).size.shortestSide <
                            kTabletBreakpoint
                        ? 68.sp
                        : 52.sp,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 3.h),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    size: MediaQuery.of(context).size.shortestSide <
                            kTabletBreakpoint
                        ? 11.sp
                        : 8.sp,
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
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
                  padding: const EdgeInsets.only(right: 8, left: 24),
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
          Padding(
            padding: EdgeInsets.only(bottom: 3.h),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                '${weather.description[0].toUpperCase()}${weather.description.substring(1)}',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.shortestSide <
                          kTabletBreakpoint
                      ? 15.sp
                      : 10.sp,
                  color: Theme.of(context).textTheme.subtitle1!.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
