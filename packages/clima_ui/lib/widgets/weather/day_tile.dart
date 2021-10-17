import 'package:clima_ui/state_notifiers/full_weather_state_notifier.dart' as w;
import 'package:clima_ui/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

class DayTile extends HookWidget {
  const DayTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dailyForecasts = useProvider(
      w.fullWeatherStateNotifierProvider.select(
        (state) => state.fullWeather!.dailyForecasts,
      ),
    );
    final timeZoneOffset = useProvider(
      w.fullWeatherStateNotifierProvider.select(
        (state) => state.fullWeather!.timeZoneOffset,
      ),
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ///TODO: Add day
          Text(
            day,
            style: kSubtitle1TextStyle(context).copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          ///TODO: Add weather icon
          SvgPicture.asset(
            weatherIcon,
            height: 6.h,
          ),
          Row(
            children: [
              Icon(
                Icons.invert_colors,
                color: Theme.of(context).textTheme.subtitle2!.color,
                size: kIconSize(context),
              ),

              ///TODO: Add rain chance
              Text(
                '$precipitation %',
                style: kSubtitle2TextStyle(context),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 4.w),

                ///TODO: Add max temp
                child: Text(
                  '${maxTemperature.round()}°',
                  style: kSubtitle1TextStyle(context),
                ),
              ),

              ///TODO: Add min temp
              Text(
                '${minTemperature.round()}°',
                style: kSubtitle2TextStyle(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
