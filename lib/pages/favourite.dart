import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/fav_model.dart';
import 'package:weather_app/pages/weather_page.dart';

class FavouriteCitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Cities'),
        centerTitle: true,
      ),
      body: Consumer<FavouriteModel>(
        builder: (context, favouriteModel, child) {
          List<String> favouriteCities = favouriteModel.favouriteCities;
          return favouriteCities.isEmpty
              ? Center(
                  child: Text('No favourite cities yet.'),
                )
              : ListView.builder(
                  itemCount: favouriteCities.length,
                  itemBuilder: (context, index) {
                    String cityName = favouriteCities[index];
                    return ListTile(
                      title: Text(cityName),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeatherPage(cityName: cityName),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          favouriteModel.removeFromFavourites(cityName);
                        },
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
