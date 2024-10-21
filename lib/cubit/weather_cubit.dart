import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class CityCubit extends Cubit<List<String>> {
  CityCubit() : super([]);
  void clearSuggetions() {
    emit([]);
  }

  void fetchCitySuggetion(String query) async {
    final response = await http.get(
        Uri.parse(
            'https://wft-geo-db.p.rapidapi.com/v1/geo/cities?namePrefix=$query'),
        headers: {
          'x-rapidapi-host': 'wft-geo-db.p.rapidapi.com',
          'x-rapidapi-key':
              'b3a8efc234mshfa17c179c5a4f0ap1d9febjsned7559305a83',
        });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<String> cities = (data['data'] as List<dynamic>)
          .map((city) => city['city'] as String)
          .toList();
      emit(cities);
    } else {
      emit([]);
    }
  }
}
