import 'package:equatable/equatable.dart';
import 'package:prayer_schedule/model/user_location_model.dart';

abstract class PrayerTimeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PrayerTimeFetch extends PrayerTimeEvent {
  final DateTime date;
  final UserLocation location;
  PrayerTimeFetch(this.date, this.location);
}