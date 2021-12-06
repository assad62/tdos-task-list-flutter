import 'package:geolocator/geolocator.dart';

abstract class ILocationRepository {

  Future<Position> getPosition();

  Future<String> getAddress(double lat, double long);


}
