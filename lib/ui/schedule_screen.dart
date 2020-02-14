import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayer_schedule/bloc/location_bloc/location_bloc.dart';
import 'package:prayer_schedule/bloc/location_bloc/location_bloc_state.dart';
import 'package:prayer_schedule/bloc/prayer_time_bloc/prayer_time_export.dart';
import 'package:prayer_schedule/model/user_location_model.dart';
import 'package:prayer_schedule/res/colors.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  PrayerTimeBloc _prayerTimeBloc;
  LocationBloc _locationBloc;
  UserLocation _location;

  @override
  void initState() {
    super.initState();
    _prayerTimeBloc = BlocProvider.of<PrayerTimeBloc>(context);
    _locationBloc = BlocProvider.of<LocationBloc>(context)
      ..listen(
        (state) {
          ///checking for getting coordinates
          if (state is LocationStateDefined) {
            ///when we get coordinates we'll dispatch PrayerTimeBloc
            _prayerTimeBloc
                .add(PrayerTimeFetch(DateTime.now(), state.userLocation));

            ///keep user location
            _location = state.userLocation;
          }
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Prayer times'),
      ),
      body: BlocBuilder(
        bloc: _locationBloc,
        builder: (context, state) {
          if (state is LocationStateInit) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is LocationStateError) {
            return Center(
              child: Text(state.exception.toString()),
            );
          }
          if (state is LocationStateDefined) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  state.userLocation.localName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                BlocBuilder(
                  bloc: _prayerTimeBloc,
                  builder: (context, prayerState) {
                    if (prayerState is PrayerTimeLoaded) {
                      return Column(
                        children: <Widget>[
                          Card(
                            child: InkWell(
                              onTap: () => _showDatePicker(),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.event,
                                      color: AppColors.qiblaBlue,
                                      size: ScreenUtil().setHeight(72),
                                    ),
                                    Text(
                                      DateFormat.yMMMMd()
                                          .format(DateTime.now()),
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text('Sunrise'),
                                            Text(
                                              prayerState.model.sunrise,
                                              style: TextStyle(
                                                  color: Colors.redAccent),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: <Widget>[
                                            Text('Sunset'),
                                            Text(
                                              prayerState.model.sunset,
                                              style: TextStyle(
                                                  color: Colors.redAccent),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Fajr"),
                                          Text(
                                            prayerState.model.fajr,
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          )
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Dhuhr"),
                                          Text(
                                            prayerState.model.dhuhr,
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          )
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Asr"),
                                          Text(
                                            prayerState.model.asr,
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          )
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Maghrib"),
                                          Text(
                                            prayerState.model.maghrib,
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          )
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Isha"),
                                          Text(
                                            prayerState.model.isha,
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    } else if (prayerState is PrayerTimeError) {
                      return Text('something went wrong');
                    } else
                      return CupertinoActivityIndicator();
                  },
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(200),
                  width: MediaQuery.of(context).size.width,
                )
              ],
            );
          }
          return null;
        },
      ),
    );
  }

  void _showDatePicker() {
    DatePicker.showDatePicker(context,
        pickerTheme: DateTimePickerTheme(
          backgroundColor: AppColors.neutral,
          confirm: Icon(Icons.check, color: AppColors.qiblaBlue),
          cancel: Icon(
            Icons.clear,
            color: Colors.redAccent,
          ),
        ),
        initialDateTime: DateTime.now(), onConfirm: (day, List<int> index) {
      _prayerTimeBloc.add(PrayerTimeFetch(day, _location));
    });
  }
}
