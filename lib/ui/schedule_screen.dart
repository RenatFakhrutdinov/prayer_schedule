import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayer_schedule/bloc/location_bloc/location_bloc.dart';
import 'package:prayer_schedule/bloc/location_bloc/location_bloc_state.dart';
import 'package:prayer_schedule/bloc/prayer_time_bloc/prayer_time_export.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  PrayerTimeBloc _prayerTimeBloc;
  LocationBloc _locationBloc;

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
                      return Text(prayerState.model.asr);
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
}
