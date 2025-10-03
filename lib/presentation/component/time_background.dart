import 'package:flutter/material.dart';

class TimeBackground extends StatelessWidget {
  final int timezoneOffset; // in seconds
  final Widget child;

  const TimeBackground({
    super.key,
    required this.timezoneOffset,
    required this.child,
  });

  LinearGradient _getGradient() {
    final now = DateTime.now().toUtc().add(Duration(seconds: timezoneOffset));
    final hour = now.hour;

    if (hour >= 5 && hour < 11) {
      // 🌅 Morning (soft yellow to light blue)
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF3A0CA3), Color(0xFF4361EE), Color(0xFF4CC9F0)],
      );
    } else if (hour >= 11 && hour < 16) {
      // ☀️ Noon (bright clear sky blue)
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF4FC3F7), // bright sky blue
          Color(0xFF0288D1), // deeper blue
        ],
      );
    } else if (hour >= 16 && hour < 20) {
      // 🌇 Evening (sunset orange to purple)
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFFF7043), // warm orange
          Color(0xFF8E24AA), // deep purple
        ],
      );
    } else {
      // 🌙 Night (deep navy to near black)
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF0D47A1), // dark navy blue
          Color(0xFF000000), // black
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: _getGradient()),
      child: child,
    );
  }
}
