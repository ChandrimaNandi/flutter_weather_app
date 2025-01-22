import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather_model.dart';

void main() {
  group('Weather.fromJson Tests', () {
    test('parses valid JSON correctly', () {
      final json = {
        'name': 'Paris',
        'main': {'temp': 20.5, 'humidity': 50},
        'weather': [
          {'main': 'Clear'}
        ],
        'wind': {'speed': 3.5}
      };

      final weather = Weather.fromJson(json);

      expect(weather.cityName, 'Paris');
      expect(weather.temperature, 20.5);
      expect(weather.maincondn, 'Clear'); // Field name preserved as maincondn
      expect(weather.humidity, 50);
      expect(weather.windSpeed, 3.5);
    });

    test('throws an exception for null JSON', () {
      expect(() => Weather.fromJson(null), throwsA(isA<Exception>()));
    });

    test('throws an exception for missing required fields', () {
      final json = {
        'main': {'temp': 20.5},
      };

      expect(() => Weather.fromJson(json), throwsA(isA<Exception>()));
    });

    test('throws an exception for invalid field types', () {
      final json = {
        'name': 123, // Invalid type, should be String
        'main': {
          'temp': 'hot',
          'humidity': 'high'
        }, // Invalid types, should be num/int
        'weather': [
          {'main': 456} // Invalid type, should be String
        ],
        'wind': {'speed': 'fast'} // Invalid type, should be num
      };

      expect(() => Weather.fromJson(json), throwsA(isA<Exception>()));
    });

    test('throws an exception when mandatory fields are completely missing',
        () {
      final Map<String, dynamic> json = {};

      expect(() => Weather.fromJson(json), throwsA(isA<Exception>()));
    });
  });
}
