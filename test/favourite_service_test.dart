import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/service/favourite_service.dart';

void main() {
  TestWidgetsFlutterBinding
      .ensureInitialized(); // Ensure bindings are initialized

  group('FavouriteService Tests', () {
    setUp(() {
      // Set up mock initial values for SharedPreferences
      SharedPreferences.setMockInitialValues({});
    });

    test('saveFavouriteCity adds a city to favourites', () async {
      await FavouriteService.saveFavouriteCity('Paris');
      final favourites = await FavouriteService.getFavouriteCities();
      expect(favourites, contains('Paris'));
    });

    test('removeFavouriteCity removes a city from favourites', () async {
      await FavouriteService.saveFavouriteCity('Paris');
      await FavouriteService.removeFavouriteCity('Paris');
      final favourites = await FavouriteService.getFavouriteCities();
      expect(favourites, isNot(contains('Paris')));
    });

    test('isFavouriteCity returns true if city is a favourite', () async {
      await FavouriteService.saveFavouriteCity('Paris');
      final isFavourite = await FavouriteService.isFavouriteCity('Paris');
      expect(isFavourite, true);
    });

    test('getFavouriteCities returns all favourite cities', () async {
      await FavouriteService.saveFavouriteCity('Paris');
      await FavouriteService.saveFavouriteCity('London');
      final favourites = await FavouriteService.getFavouriteCities();
      expect(favourites, containsAll(['Paris', 'London']));
    });
  });
}
