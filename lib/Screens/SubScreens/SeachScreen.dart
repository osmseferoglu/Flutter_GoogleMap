// ignore_for_file: avoid_print, file_names


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/Screens/SubScreens/DetailView.dart';
import 'package:flutter_map/entity/Places/Places.dart';

import 'package:flutter_map/repository/Services.dart';

import 'package:geolocator/geolocator.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.late, required this.long, required this.title}) : super(key: key);
  final double late;
  final double long;
  final String title;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<PlaceElement> placesArray = [];
  @override
  void initState() {
    super.initState();
    _initializeMap();
    
  }
  Future<void> _initializeMap() async {
    await _getCurrentLocation();
  }

  
  var lat = 0.0;
  
  var long = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Enter your search query',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              onSubmitted: (value) {
                fetchSearchText(value);
              },
              onChanged: (value) {
                if (value.toString().length > 2) {
                  fetchSearchText(value);
                }else if(value.toString().length < 2){
                  placesArray == [];
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: placesArray.length,
              itemBuilder: (context, index) {
                 if (placesArray[index].rating == null ||
                    placesArray[index].businessStatus == 'TEMPORARLY CLOSED' ||
                    placesArray[index].photos.isEmpty) {
                  return Container();
                }
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      placesArray[index].photos.isNotEmpty
                          ? 'https://places.googleapis.com/v1/${placesArray[index].photos[0].name}/media?key=AIzaSyD1tXUuJTZC5eyV_69FtNM1jhqNIBJ4JhY&max_height_px=90&max_width_px=60'
                          : 'https://placehold.co/90x60/png',
                      fit: BoxFit.fill,
                      width: 60,
                      height: 90,
                    ),
                  ),
                  title: Text(
                    placesArray[index].displayName.text,
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    placesArray[index].formattedAddress,
                    maxLines: 2,
                  ),
                  trailing: Column(
                    children: [
                      const Icon(
                        CupertinoIcons.star_fill,
                        color: Colors.yellow,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(placesArray[index].rating.toString()),
                    ],
                  ),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailView(
                          placeElement: placesArray[index],
                          isfav: false,
                        ),
                      ),
                    )
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchSearchText(String searchString) async {
    try {
      final places = await SearchService().searchText(lat,long,searchString);

      // Check for response key
      if (places != null && places.containsKey('places')) {
        setState(() {
          placesArray = places['places']
              .map<PlaceElement>((place) => PlaceElement.fromJson(place))
              .toList();
        });
       
      } else {
        print('Invalid response format');
      }
    } catch (e) {
      // check for errors
      print('Exception: $e');
    }
  }
  Future<void> _getCurrentLocation() async {
    try {
      var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        lat = position.latitude;
        long = position.longitude;
      });
    } catch (e) {
      print('Exception: $e');
    }
  }
}
