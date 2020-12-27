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
