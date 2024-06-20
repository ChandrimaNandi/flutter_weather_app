class Weather {
  final String cityName;
  final double temperature;
  final String maincondn;
  // final DateTime? time;
  final int humidity; // Percentage
  final double windSpeed; // in meters per second

  Weather({
    required this.cityName,
    required this.temperature,
    required this.maincondn,
    // required this.time,
    required this.humidity,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      // Handle case where json is null (if necessary)
      return Weather(
        cityName: '',
        temperature: 0.0,
        maincondn: '',
        // time: null,
        humidity: 0,
        windSpeed: 0.0,
      );
    }

    // Handle null or missing 'dt' field
    // DateTime? parsedTime;
    // if (json['dt'] != null) {
    //   parsedTime = DateTime.fromMillisecondsSinceEpoch(json['dt']! * 1000);
    // }

    return Weather(
      cityName: json['name'] ?? '',
      temperature: json['main'] != null && json['main']['temp'] is num
          ? (json['main']['temp'] as num).toDouble()
          : 0.0,
      maincondn: json['weather'] != null &&
              json['weather'] is List &&
              json['weather'].isNotEmpty
          ? json['weather'][0]['main'] ?? ''
          : '',
      // time: parsedTime,
      humidity: json['main'] != null && json['main']['humidity'] is int
          ? json['main']['humidity']
          : 0,
      windSpeed: json['wind'] != null && json['wind']['speed'] is num
          ? (json['wind']['speed'] as num).toDouble()
          : 0.0,
    );
  }
}
