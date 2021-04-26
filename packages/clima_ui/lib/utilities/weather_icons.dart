import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';

//returns the right weather icon for the right condition.

IconData getIconData(String iconCode) {
  switch (iconCode) {
    case '01d':
      return WeatherIcons.wiDaySunny;
    case '01n':
      return WeatherIcons.wiNightClear;
    case '02d':
      return WeatherIcons.wiDayCloudy;
    case '02n':
      return WeatherIcons.wiDayCloudy;
    case '03d':
    case '04d':
      return WeatherIcons.wiDayCloudyHigh;
    case '03n':
    case '04n':
      return WeatherIcons.wiNightClear;
    case '09d':
      return WeatherIcons.wiDayShowers;
    case '09n':
      return WeatherIcons.wiNightAltShowers;
    case '10d':
      return WeatherIcons.wiDayShowers;
    case '10n':
      return WeatherIcons.wiNightAltShowers;
    case '11d':
      return WeatherIcons.wiDayThunderstorm;
    case '11n':
      return WeatherIcons.wiNightThunderstorm;
    case '13d':
      return WeatherIcons.wiDaySnow;
    case '13n':
      return WeatherIcons.wiNightSnow;
    case '50d':
      return WeatherIcons.wiDayFog;
    case '50n':
      return WeatherIcons.wiNightFog;
    default:
      return WeatherIcons.wiDaySunny;
  }
}
