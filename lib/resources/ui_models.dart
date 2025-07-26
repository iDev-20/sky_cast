class Weather {
  final String cityName;
  final String countryName;
  final double temperature;
  final double windSpeed;
  final double feelsLike;
  final String weatherDescription;
  final int weatherId;
  final int humidity;
  final int pressure;
  final double maxTemperature;
  final double minTemperature;
  final int seaLevel;

  Weather({
    required this.cityName,
    required this.countryName,
    required this.temperature,
    required this.windSpeed,
    required this.feelsLike,
    required this.weatherDescription,
    required this.weatherId,
    required this.humidity,
    required this.pressure,
    required this.maxTemperature,
    required this.minTemperature,
    required this.seaLevel,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final main = json['main'] ?? {};
    final wind = json['wind'] ?? {};
    final weatherList = json['weather'] ?? [{}];
    final sys = json['sys'] ?? {};

    return Weather(
      cityName: json['name'] ?? '',
      countryName: sys['country'] ?? '',
      temperature: (main['temp'] ?? 0),
      windSpeed: (wind['speed'] ?? 0),
      feelsLike: (main['feels_like'] ?? 0),
      weatherDescription: weatherList[0]['description'] ?? '',
      weatherId: weatherList[0]['id'] ?? 0,
      humidity: (main['humidity'] ?? 0),
      pressure: (main['pressure'] ?? 0),
      maxTemperature: (main['temp_max'] ?? 0),
      minTemperature: (main['temp_min'] ?? 0),
      seaLevel: (main['sea_level'] ?? 0),
    );
  }
}

class Time {
  final DateTime dateTime;
  final String timeZone;
  final String dayOfWeek;
  final bool dstActive;

  Time(
      {required this.dateTime,
      required this.timeZone,
      required this.dayOfWeek,
      required this.dstActive});

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
        dateTime: DateTime.parse(json['dateTime']),
        timeZone: json['timeZone'],
        dayOfWeek: json['dayOfWeek'],
        dstActive: json['dstActive']);
  }
}
