import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/weather_page.dart';
import 'package:weather_app/pages/favourite.dart';
import 'package:weather_app/pages/search.dart';
import 'package:weather_app/pages/splash.dart';
import 'package:weather_app/models/fav_model.dart'; // Import your FavouriteModel

void main() {
  runApp(MyApp());
}

class ThemeModel extends ChangeNotifier {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => FavouriteModel()),
      ], // Provide your FavouriteModel here
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeModel.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: SplashScreen(), // Replace with your SplashScreen widget
            routes: {
              '/homepage': (context) => WeatherPage(),
              '/favpage': (context) => FavouriteCitiesPage(),
              '/searchpage': (context) => SearchPage(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == '/homepage') {
                final cityName = settings.arguments as String?;
                return MaterialPageRoute(
                  builder: (context) => WeatherPage(cityName: cityName),
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
