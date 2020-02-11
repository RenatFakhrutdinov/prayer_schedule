import 'package:equatable/equatable.dart';

abstract class PrayerTimeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PrayerTimeFetch extends PrayerTimeEvent {
  final DateTime date;
  PrayerTimeFetch(this.date);
}