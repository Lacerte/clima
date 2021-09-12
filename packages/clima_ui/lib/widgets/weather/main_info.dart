import 'package:clima_ui/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sizer/sizer.dart';

class MainInfo extends HookWidget {
  const MainInfo({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.maxTemperature,
    required this.minTemperature,
    Key? key,
  }) : super(key: key);

  final String cityName;
  final int temperature;
  final String description;
  final int maxTemperature;
  final int minTemperature;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Text(
              cityName.toUpperCase(),
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
              '${temperature.round()}°',
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
                  '${maxTemperature.round()}°',
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
                  '${minTemperature.round()}°',
                  style: kSubtitle1TextStyle(context),
                ),
              ],
            ),
          ),
          Text(
            description.toUpperCase(),
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
