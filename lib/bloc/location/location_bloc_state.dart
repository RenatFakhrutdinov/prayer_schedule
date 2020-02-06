import 'package:equatable/equatable.dart';
import 'package:prayer_schedule/bloc/location/user_location_model.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationStateInit extends LocationState {
  @override
  String toString() => "LocationStateInit";
}

class LocationStateDefined extends LocationState {
  final UserLocation userLocation;

  LocationStateDefined({this.userLocation});

  @override
  String toString() => "LocationStateDefined";
}

class LocationStateError extends LocationState {
  final Exception exception;

  LocationStateError(this.exception);

  @override
  String toString() => "LocationStateError";
}
