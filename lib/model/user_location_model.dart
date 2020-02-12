import 'package:geolocator/geolocator.dart';

class UserLocation {
  double latitude;
  double longitude;
  Position position;

  String localName;
  List<Placemark> placeMarks = List();

  ///todo define timezone

  UserLocation(Position position, List<Placemark> places) {
    latitude = position.latitude;
    longitude = position.longitude;
    this.position = position;
    localName = places.first.locality;
    placeMarks = places;
  }
}
