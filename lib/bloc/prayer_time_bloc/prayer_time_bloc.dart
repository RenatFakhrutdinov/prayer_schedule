import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_schedule/bloc/prayer_time_bloc/prayer_time_event.dart';
import 'package:prayer_schedule/bloc/prayer_time_bloc/prayer_time_export.dart';
import 'package:prayer_schedule/model/prayer_time_model.dart';

class PrayerTimeBloc extends Bloc<PrayerTimeEvent, PrayerTimeState> {
  @override
  PrayerTimeState get initialState => PrayerTimeEmpty();

  @override
  Stream<PrayerTimeState> mapEventToState(PrayerTimeEvent event) async* {
    if (event is PrayerTimeFetch) {
      yield PrayerTimeLoading();
      try {
        PrayerTimeModel model = PrayerTimeModel.fromDateAndCoordinates(
            date: event.date,
            latitude: event.location.latitude,
            longitude: event.location.longitude,
            timezone: 0);
        if (model == null) {
          yield PrayerTimeEmpty();
        } else
          yield PrayerTimeLoaded(model);
      } catch (e) {
        print("PrayerTimeBloc error: $e");
        yield PrayerTimeError();
      }
    }
  }
}
