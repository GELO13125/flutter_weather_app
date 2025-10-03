// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/bloc/weather_bloc.dart';
import 'package:flutter_weather_app/bloc/weather_event.dart';
import 'package:flutter_weather_app/bloc/weather_state.dart';
import 'package:flutter_weather_app/presentation/component/search_field.dart';
import 'package:flutter_weather_app/presentation/component/weather_card.dart';
import 'package:flutter_weather_app/presentation/component/weather_icon.dart';
import 'package:flutter_weather_app/presentation/component/time_display.dart';
import 'package:flutter_weather_app/presentation/component/time_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController(
    text: 'Enter City Name',
  );

  void _search() {
    final city = _controller.text.trim();
    if (city.isNotEmpty) {
      context.read<WeatherBloc>().add(FetchWeather(city));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true, // ensures scroll when keyboard shows

      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          int timezoneOffset = 0;
          if (state is WeatherLoaded) {
            timezoneOffset = state.weather.timezoneOffset;
          }

          return TimeBackground(
            timezoneOffset: timezoneOffset,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 120, 16, 24),
              child: SingleChildScrollView(
                reverse: true, // keeps bottom visible when keyboard appears
                child: Column(
                  children: [
                    SearchField(controller: _controller, onSearch: _search),

                    if (state is WeatherLoaded) ...[
                      SizedBox(
                        height: 310,
                        width: 310,
                        child: WeatherIcon(code: state.weather.conditionCode),
                      ),
                      const SizedBox(height: 8),
                      TimeDisplay(timezoneOffset: state.weather.timezoneOffset),
                    ] else if (state is WeatherInitial) ...[
                      const SizedBox(height: 40),
                      const Text(
                        'Enter a city to get weather',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ] else if (state is WeatherLoading) ...[
                      const SizedBox(height: 40),
                      const Center(child: CircularProgressIndicator()),
                    ] else if (state is WeatherError) ...[
                      const SizedBox(height: 40),
                      Text(
                        'Error: ${state.message}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],

                    const SizedBox(height: 20),
                    if (state is WeatherLoaded)
                      WeatherCard(weather: state.weather),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: _search,
                        child: const Text(
                          'Search',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
