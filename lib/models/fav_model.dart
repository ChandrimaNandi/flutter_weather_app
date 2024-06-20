import 'package:flutter/foundation.dart';

class FavouriteModel extends ChangeNotifier {
  List<String> _favouriteCities = [];

  List<String> get favouriteCities => _favouriteCities;

  void addToFavourites(String cityName) {
    if (!_favouriteCities.contains(cityName)) {
      _favouriteCities.add(cityName);
      notifyListeners();
    }
  }

  void removeFromFavourites(String cityName) {
    if (_favouriteCities.contains(cityName)) {
      _favouriteCities.remove(cityName);
      notifyListeners();
    }
  }

  bool isFavourite(String cityName) {
    return _favouriteCities.contains(cityName);
  }
}
