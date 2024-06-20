import 'package:shared_preferences/shared_preferences.dart';

class FavouriteService {
  static const String _keyFavourites = 'FavouriteCities';

  // Method to save a city as Favourite
  static Future<void> saveFavouriteCity(String cityName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? Favourites = prefs.getStringList(_keyFavourites);

    if (Favourites == null) {
      Favourites = [];
    }

    if (!Favourites.contains(cityName)) {
      Favourites.add(cityName);
    }

    await prefs.setStringList(_keyFavourites, Favourites);
  }

  // Method to remove a city from Favourites
  static Future<void> removeFavouriteCity(String cityName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? Favourites = prefs.getStringList(_keyFavourites);

    if (Favourites != null && Favourites.contains(cityName)) {
      Favourites.remove(cityName);
      await prefs.setStringList(_keyFavourites, Favourites);
    }
  }

  // Method to check if a city is a Favourite
  static Future<bool> isFavouriteCity(String cityName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? Favourites = prefs.getStringList(_keyFavourites);

    return Favourites != null && Favourites.contains(cityName);
  }

  // Method to get all Favourite cities
  static Future<List<String>> getFavouriteCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? Favourites = prefs.getStringList(_keyFavourites);

    return Favourites ?? [];
  }
}
