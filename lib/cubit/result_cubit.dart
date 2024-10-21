import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherinitialState());
  final String apiKey = '816be57b2de547d198644516243007';
  final String baseUrl = 'http://api.weatherapi.com/v1/current.json';

  Future<void> fetchWeatherdata(String cityName) async {
    emit(WeatherLoadingState());
    final response =
        await http.get(Uri.parse('$baseUrl?key=$apiKey&q=$cityName&aqi=no'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final temperature = data['current']['temp_c'];
      final condition = data['current']['condition']['text'];
      print('Weather is $temperature');
      print('Weather is $condition');
      emit(WeatherLoadedState(temperature: temperature, condition: condition));
    } else {
      emit(WeatherErrorState(errorMessege: 'unable to fetch data'));
    }
  }
}

class WeatherState {}

class WeatherinitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final double temperature;
  final String condition;
  WeatherLoadedState({
    required this.temperature,
    required this.condition,
  });
}

class WeatherErrorState extends WeatherState {
  final String errorMessege;
  WeatherErrorState({
    required this.errorMessege,
  });
}
