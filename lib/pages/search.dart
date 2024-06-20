// import 'package:flutter/material.dart';
// import 'package:weather_app/models/weather_model.dart';
// import 'package:weather_app/service/weather_service.dart';
// import 'package:weather_app/pages/weather_page.dart';
// import 'package:weather_app/service/weather_service.dart';

// class SearchPage extends StatefulWidget {
//   const SearchPage({Key? key}) : super(key: key);

//   @override
//   _SearchPageState createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   final TextEditingController _searchController = TextEditingController();
//   final WeatherService _weatherService =
//       WeatherService('fc6ebbcdd87e6bc21f30d9244d273d44');
//   List<Weather> _searchResults = [];

//   void _searchWeather(String cityName) async {
//     try {
//       Weather weather = await _weatherService.getWeather(cityName);
//       setState(() {
//         _searchResults = [weather];
//       });
//     } catch (e) {
//       print('Error searching weather: $e');
//       setState(() {
//         _searchResults = [];
//       });
//     }
//   }

//   void navigateToWeatherPage(String cityName) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => WeatherPage(cityName: cityName),
//       ),
//     );
//   }

//   void _getCurrentLocationWeather()async{
//     setState(() {
//       _is
//     });
//   }
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           "Search for a city",
//           style: TextStyle(fontSize: 20, color: Colors.black),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.blueGrey[200],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 20),
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0)),
//                 filled: true,
//                 fillColor: Colors.blueGrey[200],
//                 hintText: 'Enter city name',
//                 prefixIcon: Icon(Icons.search),
//                 prefixIconColor: Colors.black,
//               ),
//               onSubmitted: (value) {
//                 if (value.isNotEmpty) {
//                   _searchWeather(value);
//                 }
//               },
//             ),
//             SizedBox(height: 20),
//             ListTile(
//               leading: Icon(Icons.my_location),
//               title: Text('Use current location'),
//               onTap: () {
//                 //get the current location and send it to the weather page
//                 //to get the weather data
//               },
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: _searchResults.isEmpty
//                   ? Center(child: Text('No results found'))
//                   : ListView.builder(
//                       itemCount: _searchResults.length,
//                       itemBuilder: (context, index) {
//                         Weather weather = _searchResults[index];
//                         return ListTile(
//                           title: Text(weather.cityName),
//                           subtitle: Text('${weather.temperature.round()}°C'),
//                           onTap: () {
//                             //to navigate to the weather page with the searched city
//                             navigateToWeatherPage(weather.cityName);
//                           },
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';
import 'package:weather_app/pages/weather_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final WeatherService _weatherService =
      WeatherService('fc6ebbcdd87e6bc21f30d9244d273d44');
  List<Weather> _searchResults = [];
  bool _isSearching = false;

  void _searchWeather(String cityName) async {
    setState(() {
      _isSearching = true;
    });
    try {
      Weather weather = await _weatherService.getWeather(cityName);
      setState(() {
        _searchResults = [weather];
      });
    } catch (e) {
      print('Error searching weather: $e');
      setState(() {
        _searchResults = [];
      });
    } finally {
      setState(() {
        _isSearching = false;
      });
    }
  }

  void navigateToWeatherPage(String cityName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherPage(cityName: cityName),
      ),
    );
  }

  void _getCurrentLocationWeather() async {
    setState(() {
      _isSearching = true;
    });
    try {
      String cityName = await _weatherService.getCurrentCity();
      _searchWeather(cityName);
      navigateToWeatherPage(cityName);
    } catch (e) {
      print('Error getting current location weather: $e');
      setState(() {
        _isSearching = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Search for a city",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                filled: true,
                fillColor: Colors.blueGrey[200],
                hintText: 'Enter city name or use current location',
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.black,
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _searchWeather(value);
                }
              },
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.my_location),
              title: Text('Use current location'),
              onTap: _getCurrentLocationWeather,
            ),
            SizedBox(height: 20),
            Expanded(
              child: _isSearching
                  ? Center(
                      child: CircularProgressIndicator(
                          color: Colors.blueGrey[200]),
                    )
                  : _searchResults.isEmpty
                      ? Center(child: Text('No results found'))
                      : ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            Weather weather = _searchResults[index];
                            return ListTile(
                              title: Text(weather.cityName),
                              subtitle:
                                  Text('${weather.temperature.round()}°C'),
                              onTap: () {
                                navigateToWeatherPage(weather.cityName);
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
