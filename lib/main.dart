import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/location/location_bloc.dart';
import 'res/colors.dart';
import 'ui/schedule_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<LocationBloc>(
            create: (BuildContext context) =>
                LocationBloc()..add(LocationEvent.fetchLocation),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
              primaryColor: AppColors.neutral,
              highlightColor: Colors.transparent,
              textTheme: TextTheme(
                  body1: TextStyle(
                    color: Colors.black54,
                  ),
                  title: TextStyle(
                    color: Colors.black54,
                  )),
              primaryTextTheme:
                  TextTheme(title: TextStyle(color: Colors.black54)),
              appBarTheme: AppBarTheme(elevation: 0, color: Colors.grey[50])),
          home: ScheduleScreen(),
        ),
      ),
    );
  });
}
