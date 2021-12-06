import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class LocationService {

  static final LocationService _singleton = LocationService._internal();
  factory LocationService() {
    return _singleton;
  }
  LocationService._internal();

  Future<String> _determineAddressFromLatLong(double lat, double long)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat,long);
    print(placemarks);
    Placemark place = placemarks[0];
    return '${place.street}, ${place.administrativeArea}, ${place.country}';

  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<Position> getPosition()async{
    return await _determinePosition();
  }

  Future<String> getAddress(double lat, double long) async{

    return await _determineAddressFromLatLong(lat, long);
  }




}