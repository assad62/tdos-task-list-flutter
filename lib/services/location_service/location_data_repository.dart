import 'package:flutter_starter_app/repositories/location_repository/location_repo.dart';
import 'package:flutter_starter_app/services/location_service/location_service.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';

class LocationDataRepository extends ILocationRepository{

  var _service = LocationService();
  @override
  Future<String> getAddress(double lat, double long) async{

    return await _service.getAddress(lat, long);

  }

  @override
  Future<Position> getPosition() async {

    return await _service.getPosition();
  }

}