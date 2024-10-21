import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/cubit/result_cubit.dart';

class ResultScreen extends StatelessWidget {
  final String city;
  ResultScreen({required this.city});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Result screen'),
        ),
        body: BlocProvider(
          create: (context) {
            final cubit = WeatherCubit();
            cubit.fetchWeatherdata(city);
            return cubit;
          },
          child: BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
            if (state is WeatherLoadingState) {
              return CircularProgressIndicator();
            } else if (state is WeatherLoadedState) {
              return Center(
                child: Container(
                  height: 300,
                  width: 300,
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Temperature: ${state.temperature}°C',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Condition:${state.condition}',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              );
            } else if (state is WeatherErrorState) {
              return Text(
                '${state.errorMessege}',
                style: TextStyle(color: Colors.red, fontSize: 16),
              );
            } else {
              return Text(' No data avilble');
            }
          }),
        ));
  }
}
