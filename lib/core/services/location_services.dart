import 'package:location/location.dart';
import 'package:siraj/core/constants/strings.dart';

class LocationServices {
  static Future<dynamic> getCurrentLocation() async {
    final Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return AppStrings.locationServicesAreDisabled;
      }
    }
    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission == PermissionStatus.denied) {
        return AppStrings.locationPermissionsAreDenied;
      }
    }
    if (permission == PermissionStatus.deniedForever) {
      return AppStrings.locationPermissionsArePermanentlyDenied;
    }
    try {
      LocationData locationData = await location.getLocation();
      return locationData;
    } catch (error) {
      return error.toString();
    }
  }
}
