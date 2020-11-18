import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Future<dynamic> getCurrentLocation() async {
    final bool isLocationServiceEnabled =
        await Geolocator.isLocationServiceEnabled();
    final LocationPermission permission = await Geolocator.checkPermission();
    //print(permission);
    if (isLocationServiceEnabled == true) {
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        final Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);

        latitude = position.latitude;
        longitude = position.longitude;
      } else if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
        final LocationPermission permissionAgain =
            await Geolocator.checkPermission();
        if (permissionAgain == LocationPermission.denied ||
            permissionAgain == LocationPermission.deniedForever) {
          return 4;
        } else {
          await getCurrentLocation();
        }
      } else if (permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        final LocationPermission permissionAgain2 =
            await Geolocator.checkPermission();
        if (permissionAgain2 == LocationPermission.denied ||
            permissionAgain2 == LocationPermission.deniedForever) {
          return 4;
        } else {
          await getCurrentLocation();
        }
      }
    } else {
      return 3;
    }
  }
}
