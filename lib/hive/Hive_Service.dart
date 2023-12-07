// ignore_for_file: file_names, avoid_print

import 'package:flutter_map/entity/Places/Places.dart';
import 'package:hive/hive.dart';

class HiveService {
  Future<void> writeToBox(String id, Place placeApiResponse) async {
    Place place = Place(places: List.from(placeApiResponse.places));

    var placeBox = await Hive.openBox<Place>('placeBox');

    await placeBox.put(id, place);

    // Close the box when done
    placeBox.close();
  }

  Future<List<PlaceElement>> readFromBox() async {
    try {
      var placeBox = await Hive.openBox<Place>('placeBox');

      List<Place> places = placeBox.values.toList();

      List<PlaceElement> placeElements = [];

      if (places.isNotEmpty) {
        for (Place place in places) {
          placeElements.addAll(place.places);
        }
      } else {
        print('The box is empty');
      }

      // Close the box when done
      placeBox.close();

      return placeElements;
    } catch (e) {
      print('Error reading from box: $e');
      return [];
    }
  }

  Future<void> deleteItemFromBox(String key) async {
    var placeBox = await Hive.openBox<Place>('placeBox');
    await placeBox.delete(key);
    placeBox.close();
  }

  Future<void> clearBox() async {
    var placeBox = await Hive.openBox<Place>('placeBox');
    await placeBox.clear();
    placeBox.close();
  }

  Future<void> addToFavorites(PlaceElement placeElement) async {
    try {
      var favoritesBox = await Hive.openBox<PlaceElement>('favoritesBox');
      await favoritesBox.add(placeElement);
      favoritesBox.close();
    } catch (e) {
      print('Error adding to favorites: $e');
    }
  }

  Future<List<PlaceElement>> getFavorites() async {
    try {
      var favoritesBox = await Hive.openBox<PlaceElement>('favoritesBox');
      List<PlaceElement> favorites = favoritesBox.values.toList();
      favoritesBox.close();
      return favorites;
    } catch (e) {
      print('Error getting favorites: $e');
      return [];
    }
  }
  Future<void> deleteFavorite(String key) async {
    var favoritesBox = await Hive.openBox<PlaceElement>('favoritesBox');
    await favoritesBox.delete(key);
    favoritesBox.close();
  }
}
