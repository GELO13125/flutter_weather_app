import 'package:flutter/material.dart';

class TimeDisplay extends StatelessWidget {
  final int timezoneOffset;

  const TimeDisplay({super.key, required this.timezoneOffset});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: Stream.periodic(
        const Duration(seconds: 1),
        (_) => DateTime.now().toUtc(),
      ),
      builder: (context, snapshot) {
        final utcNow = snapshot.data ?? DateTime.now().toUtc();

        final localTime = utcNow.add(Duration(seconds: timezoneOffset));

        int hour = localTime.hour % 12 == 0 ? 12 : localTime.hour % 12;
        String period = localTime.hour >= 12 ? "PM" : "AM";

        final formatted =
            "${hour.toString().padLeft(2, '0')}:${localTime.minute.toString().padLeft(2, '0')} $period";

        return Text(
          formatted,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 4,
                color: Colors.black54,
                offset: Offset(1, 1),
              ),
            ],
          ),
        );
      },
    );
  }
}
