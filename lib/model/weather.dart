class Weather {
  final String cityName;
  final String conditionMain;
  final String conditionDescription;
  final double temperatureCelsius;
  final int humidity;
  final double windSpeed;
  final int conditionCode;
  final int timezoneOffset;

  Weather({
    required this.cityName,
    required this.conditionMain,
    required this.conditionDescription,
    required this.temperatureCelsius,
    required this.humidity,
    required this.windSpeed,
    required this.conditionCode,
    required this.timezoneOffset,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as String? ?? '';
    final weather = (json['weather'] as List).isNotEmpty
        ? json['weather'][0]
        : null;
    final main = json['main'] as Map<String, dynamic>;
    final wind = json['wind'] as Map<String, dynamic>;

    final double tempK = (main['temp'] as num).toDouble();
    final tempC = tempK - 273.15;

    return Weather(
      cityName: name,
      conditionMain: weather != null ? (weather['main'] as String) : 'Unknown',
      conditionDescription: weather != null
          ? (weather['description'] as String)
          : '',
      temperatureCelsius: tempC,
      humidity: (main['humidity'] as num).toInt(),
      windSpeed: (wind['speed'] as num).toDouble(),
      conditionCode: weather != null && weather['id'] != null
          ? (weather['id'] as num).toInt()
          : 0,
      timezoneOffset: (json['timezone'] as num?)?.toInt() ?? 0,
    );
  }
}
