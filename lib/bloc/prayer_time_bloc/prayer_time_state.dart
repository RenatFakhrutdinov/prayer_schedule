import 'package:equatable/equatable.dart';
import 'package:prayer_schedule/model/prayer_time_model.dart';

abstract class PrayerTimeState extends Equatable {
  @override
  List<Object> get props => [];
}

class PrayerTimeEmpty extends PrayerTimeState{}

class PrayerTimeLoading extends PrayerTimeState{}

class PrayerTimeLoaded extends PrayerTimeState{
  final PrayerTimeModel model;

  PrayerTimeLoaded(this.model);
}

class PrayerTimeError extends PrayerTimeState{}
