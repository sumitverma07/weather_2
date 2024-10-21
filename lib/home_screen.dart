import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/cubit/weather_cubit.dart';
import 'package:weather_app2/result_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Screen'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter the City',
            ),
            onChanged: (query) {
              context.read<CityCubit>().fetchCitySuggetion(query);
            },
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultScreen(
                              city: _controller.text,
                            )));
              },
              child: Text('Search')),
          Expanded(
            child:
                BlocBuilder<CityCubit, List<String>>(builder: (context, city) {
              return ListView.builder(
                  itemCount: city.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(city[index]),
                      onTap: () {
                        _controller.text = city[index];
                        context.read<CityCubit>().clearSuggetions();
                      },
                    );
                  });
            }),
          ),
        ],
      ),
    );
  }
}
