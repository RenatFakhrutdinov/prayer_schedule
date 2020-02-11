import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_schedule/bloc/prayer_time_bloc/prayer_time_event.dart';
import 'package:prayer_schedule/bloc/prayer_time_bloc/prayer_time_export.dart';

class PrayerTimeBloc extends Bloc<PrayerTimeEvent, PrayerTimeState> {
  @override
  PrayerTimeState get initialState => PrayerTimeEmpty();

  @override
  Stream<PrayerTimeState> mapEventToState(PrayerTimeEvent event) async*{
    yield PrayerTimeLoading();
    try{
      ///todo get prayer time model
      ///yield PrayerTimeLoaded(model);
    } catch (e) {
      print("PrayerTimeBloc error: $e");
      yield PrayerTimeError();
    }
  }
}