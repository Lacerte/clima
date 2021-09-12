import 'package:clima_ui/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class HourlyForecast extends HookWidget {
  const HourlyForecast({
    required this.temperature,
    required this.weatherIcon,
    required this.hour,
    required this.precipitation,
    required this.itemCount,
    Key? key,
  }) : super(key: key);

  final int temperature;
  final String weatherIcon;
  final DateTime hour;
  final int precipitation;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: itemCount,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                hour.toString(),
                style: kSubtitle2TextStyle(context),
              ),
              SvgPicture.asset(
                weatherIcon,
                height: 6.h,
              ),
              Text(
                '${temperature.round()}°',
                style: kSubtitle1TextStyle(context),
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
            ],
          ),
        );
      },
    );
  }
}
