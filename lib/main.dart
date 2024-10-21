import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/cubit/result_cubit.dart';
import 'package:weather_app2/cubit/weather_cubit.dart';
import 'package:weather_app2/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CityCubit()),
          BlocProvider(create: (context) => WeatherCubit()),
        ],
        child: MaterialApp(
          home: HomeScreen(),
        ));
  }
}
