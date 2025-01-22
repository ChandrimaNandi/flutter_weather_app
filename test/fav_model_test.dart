import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/fav_model.dart';

void main() {
  group('FavouriteModel Tests', () {
    test('addToFavourites should add a city to favourites', () {
      final favModel = FavouriteModel();
      favModel.addToFavourites('Paris');
      expect(favModel.favouriteCities, contains('Paris'));
    });

    test('removeFromFavourites should remove a city from favourites', () {
      final favModel = FavouriteModel();
      favModel.addToFavourites('Paris');
      favModel.removeFromFavourites('Paris');
      expect(favModel.favouriteCities, isNot(contains('Paris')));
    });

    test('isFavourite should return true for a favourite city', () {
      final favModel = FavouriteModel();
      favModel.addToFavourites('Paris');
      expect(favModel.isFavourite('Paris'), true);
    });
  });
}
