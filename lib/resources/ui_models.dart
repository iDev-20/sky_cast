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

class HourlyWeather {
  final double temperature;
  final int weatherId;
  final DateTime dateTime;

  HourlyWeather({
    required this.temperature,
    required this.weatherId,
    required this.dateTime,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    final main = json['main'] ?? {};
    final weatherList = json['weather'] ?? [{}];
    final dtTxt = json['dt_txt'];

    DateTime parsedDateTime;

    try {
      parsedDateTime = DateTime.parse(dtTxt ?? '');
    } catch (e) {
      parsedDateTime = DateTime.now();
    }

    return HourlyWeather(
      temperature: (main['temp'] as num).toDouble(),
      weatherId: weatherList[0]['id'] ?? 0,
      dateTime: parsedDateTime,
    );
  }
  static List<HourlyWeather> fromForecastJson(Map<String, dynamic> json) {
    final list = json['list'] as List<dynamic>? ?? [];
    return list
        .map((item) => HourlyWeather.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}

class Time {
  final String time;
  final String date;
  final String timeZone;
  final String dayOfWeek;
  final bool dstActive;

  Time(
      {required this.time,
      required this.date,
      required this.timeZone,
      required this.dayOfWeek,
      required this.dstActive});

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
        time: json['time'],
        date: json['date'],
        timeZone: json['timeZone'],
        dayOfWeek: json['dayOfWeek'],
        dstActive: json['dstActive']);
  }
}
