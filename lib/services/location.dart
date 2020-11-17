import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Future<dynamic> getCurrentLocation() async {
    final bool isLocationServiceEnabled =
        await Geolocator().isLocationServiceEnabled();
    if (isLocationServiceEnabled == true) {
      final Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      latitude = position.latitude;
      longitude = position.longitude;
    } else {
      return 3;
    }
  }
}
