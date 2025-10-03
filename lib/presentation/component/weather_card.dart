import 'package:flutter/material.dart';
import 'package:flutter_weather_app/model/weather.dart';
import 'info_column.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  LinearGradient _getCardGradient(int timezoneOffset) {
    final now = DateTime.now().toUtc().add(Duration(seconds: timezoneOffset));
    final hour = now.hour;

    if (hour >= 5 && hour < 11) {
      // 🌅 Morning (your current colors)
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF5E60CE), Color(0xFF4CC9F0)],
      );
    } else if (hour >= 11 && hour < 16) {
      // 🌞 Noon - brighter blue tones
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF4361EE), Color(0xFF4895EF)],
      );
    } else if (hour >= 16 && hour < 20) {
      // 🌇 Evening - warm purple/pink tones
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFF72585), Color.fromARGB(255, 113, 25, 100)],
      );
    } else {
      // 🌌 Night - deep indigo/blue tones
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color.fromARGB(255, 26, 68, 237), Color(0xFF1B1B2F)],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const double normalTemp = 25.0;

    return Container(
      decoration: BoxDecoration(
        gradient: _getCardGradient(weather.timezoneOffset),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              weather.cityName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${weather.conditionMain} — ${weather.conditionDescription}',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${weather.temperatureCelsius.toStringAsFixed(1)} °C',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                if (weather.temperatureCelsius > normalTemp)
                  Image.asset('assets/13.png', height: 40, width: 40)
                else
                  Image.asset('assets/14.png', height: 40, width: 40),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InfoColumn(title: 'Humidity', value: '${weather.humidity}%'),
                const SizedBox(width: 24),
                InfoColumn(title: 'Wind', value: '${weather.windSpeed} m/s'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
