import 'package:flutter/cupertino.dart';
import 'package:prayer_schedule/prayer_time/prayer_time.dart';

class PrayerTimeModel {
  String fajr, sunrise, dhuhr, asr, sunset, maghrib, isha;

  PrayerTimeModel(
      {this.fajr,
      this.sunrise,
      this.dhuhr,
      this.asr,
      this.sunset,
      this.maghrib,
      this.isha});

  PrayerTimeModel.fromDateAndCoordinates(
      {@required DateTime date,
      @required double latitude,
      @required double longitude,
      @required double timezone}) {
    List<String> _times =
        PrayerTime().getPrayerTimes(date, latitude, longitude, timezone);

    fajr = _times.first;
    sunrise = _times[1];
    dhuhr = _times[2];
    asr = _times[3];
    sunset = _times[4];
    maghrib = _times[5];
    isha = _times.last;
  }
}
