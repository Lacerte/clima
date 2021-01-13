/// Located in services/location.
/// This file is an archive for the get current location's feature,
/// which got removed due to Geolocater using LocationManager which in turns uses GMS

// import 'package:geolocator/geolocator.dart';
//
// class LocationServicesTurnedOff implements Exception {}
//
// class LocationPermissionDenied implements Exception {}
//
// class Location {
//   double latitude;
//   double longitude;
//
//   /// This function is responsible to get the latitude and longitude using the Geolocator package.
//   Future<void> getCurrentLocation() async {
//     final bool isLocationServiceEnabled =
//         await Geolocator.isLocationServiceEnabled();
//     final LocationPermission permission = await Geolocator.checkPermission();
//     if (isLocationServiceEnabled) {
//       if (permission == LocationPermission.whileInUse ||
//           permission == LocationPermission.always) {
//         final Position position = await Geolocator.getCurrentPosition(
//             desiredAccuracy: LocationAccuracy.low);
//
//         latitude = position.latitude;
//         longitude = position.longitude;
//       } else if (permission == LocationPermission.denied) {
//         await Geolocator.requestPermission();
//         final LocationPermission permissionAgain =
//             await Geolocator.checkPermission();
//         if (permissionAgain == LocationPermission.denied ||
//             permissionAgain == LocationPermission.deniedForever) {
//           throw LocationPermissionDenied();
//         } else {
//           await getCurrentLocation();
//         }
//       } else {
//         await Geolocator.openAppSettings();
//         throw LocationPermissionDenied();
//       }
//     } else {
//       throw LocationServicesTurnedOff();
//     }
//   }
// }

/// Located under the errorHandler functions in loaction_screen.dart

// } on LocationServicesTurnedOff {
//   _scaffoldKey.currentState.showSnackBar(
//     await snackBar(
//       text: 'Location is turned off.',
//       action: SnackBarAction(
//         label: 'Turn on',
//         onPressed: () async {
//           await Geolocator.openLocationSettings();
//         },
//       ),
//     ),
//   );
//  } on LocationPermissionDenied {
//   _scaffoldKey.currentState.showSnackBar(
//     await snackBar(text: 'Permission denied.'),
//   );

/// The get current geographic location's weather button.
// IconButton(
//   icon: const Icon(Icons.location_on_outlined),
//   tooltip: "Get current geographic location's weather",
//   onPressed: () {
//     setState(() {
//       isVisible = true;
//     });
//     errorHandler(
//       future: weather.getLocationWeather(),
//       errorMessage: "Can't connect to server.",
//     );
//   },
// ),

/// This function gets the weatherData using geographic coordinates.
/// located under the WeatherModel class in weather.dart

// Future<dynamic> getLocationWeather() async {
//   final Location location = Location();
//   await location.getCurrentLocation();
//
//   final NetworkHelper networkHelper = NetworkHelper(
//     '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric',
//   );
//
//   final dynamic weatherData = await networkHelper.getData();
//   return weatherData;
// }
