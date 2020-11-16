import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Future<dynamic> getCurrentLocation() async {
    // try {
    //   final Position position = await Geolocator()
    //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    //
    //   latitude = position.latitude;
    //   longitude = position.longitude;
    // } catch (e) {
    //   // latitude = null;
    //   // longitude = null;
    //   //return 0;
    // }
    bool isLocationServiceEnabled =
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
