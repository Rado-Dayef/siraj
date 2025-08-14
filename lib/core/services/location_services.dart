import 'package:geolocator/geolocator.dart';
import 'package:siraj/core/constants/strings.dart';

class LocationService {
  static Future<dynamic> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return AppStrings.locationServicesAreDisabled;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return AppStrings.locationPermissionsAreDenied;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return AppStrings.locationPermissionsArePermanentlyDenied;
    }
    return await Geolocator.getCurrentPosition();
  }
}
