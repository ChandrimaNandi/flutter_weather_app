import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';
import 'weather_service_test.mocks.dart';

@GenerateMocks([WeatherService])
void main() {
  final service = MockWeatherService();

  group('WeatherService Tests', () {
    test('getWeather returns valid Weather object', () async {
      // Mock data
      final weather = Weather(
        cityName: 'Paris',
        temperature: 15.0,
        maincondn: 'Cloudy',
        humidity: 60,
        windSpeed: 5.0,
      );

      // Stub the getWeather method
      when(service.getWeather('Paris')).thenAnswer((_) async => weather);

      // Call the method and check assertions
      final result = await service.getWeather('Paris');

      expect(result.cityName, 'Paris');
      expect(result.temperature, 15.0);
      expect(result.maincondn, 'Cloudy');
      expect(result.humidity, 60);
      expect(result.windSpeed, 5.0);
    });

    test('getWeather throws an exception for invalid city', () async {
      // Stub the getWeather method to throw an exception
      when(service.getWeather('InvalidCity'))
          .thenThrow(Exception('City not found'));

      // Verify that the exception is thrown
      expect(
          () => service.getWeather('InvalidCity'), throwsA(isA<Exception>()));
    });
  });
}
