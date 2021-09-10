//returns the right weather icon for the right condition.

String getWeatherIcon(String iconCode) {
  switch (iconCode) {
    case '01d':
      return 'assets/day.svg';

    case '01n':
      return 'assets/night.svg';
    case '02d':
      return 'assets/cloudy_day.svg';
    case '02n':
      return 'assets/cloudy_night.svg';
    case '03d':
    case '03n':
    case '04d':
    case '04n':
      return 'assets/cloudy.svg';
    case '09d':
    case '09n':
    case '10d':
    case '10n':
      return 'assets/rainy.svg';
    case '11d':
    case '11n':
      return 'assets/thunder.svg';
    case '13d':
    case '13n':
      return 'assets/snowy.svg';

    ///TODO: Add smog icon
    // case '50d':
    // case '50n':
    //   return FontAwesomeIcons.smog;
    default:
      return 'assets/day.svg';
  }
}
