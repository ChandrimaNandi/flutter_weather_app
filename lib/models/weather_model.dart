class Weather {
  final String cityName;
  final double temperature;
  final String maincondn;
  final int humidity; // Percentage
  final double windSpeed; // in meters per second

  Weather({
    required this.cityName,
    required this.temperature,
    required this.maincondn,
    required this.humidity,
    required this.windSpeed,
  });

  /// Factory constructor to create a Weather object from JSON
  factory Weather.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw Exception("JSON data is null");
    }

    // Check for required fields and throw exceptions if missing
    if (json['name'] == null ||
        json['main'] == null ||
        json['main']['temp'] == null ||
        json['main']['humidity'] == null ||
        json['wind'] == null ||
        json['wind']['speed'] == null ||
        json['weather'] == null ||
        !(json['weather'] is List) ||
        json['weather'].isEmpty ||
        json['weather'][0]['main'] == null) {
      throw Exception("Missing required fields in JSON");
    }

    try {
      // Safely parse the values
      return Weather(
        cityName: json['name'] as String,
        temperature: (json['main']['temp'] as num).toDouble(),
        maincondn: json['weather'][0]['main'] as String,
        humidity: json['main']['humidity'] as int,
        windSpeed: (json['wind']['speed'] as num).toDouble(),
      );
    } catch (e) {
      throw Exception("Error parsing Weather data: $e");
    }
  }

  /// Converts the Weather object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'main': {
        'temp': temperature,
        'humidity': humidity,
      },
      'weather': [
        {'main': maincondn},
      ],
      'wind': {
        'speed': windSpeed,
      },
    };
  }
}
