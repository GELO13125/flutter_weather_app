import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/presentation/home_screen.dart';
import 'repository/weather_repository.dart';
import 'bloc/weather_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final WeatherRepository repository = WeatherRepository();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App (Exam)',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: BlocProvider(
        create: (_) => WeatherBloc(repository: repository),
        child: HomeScreen(),
      ),
    );
  }
}
