// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';


import 'package:flutter_map/Constants.dart';
import 'package:flutter_map/entity/Places/Places.dart';
import 'package:flutter_map/hive/Hive_Service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class PlacesService {
  String apiKey = Constants().getApiKey();
  String url = Constants().getSearchNearbyUrl();

  

  PlacesService();

  Future<List<PlaceElement>> searchNearbyPlaces(
      double lat, double long, String searchType) async {
    final headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': apiKey,
      'X-Goog-FieldMask': Constants().getParameters(),
    };

    final body = jsonEncode({
      'includedTypes': [searchType],
      'maxResultCount': 20,
      "rankPreference": "DISTANCE",
      'locationRestriction': {
        'circle': {
          'center': {'latitude': lat, 'longitude': long},
          'radius': 10000.0,
        },
      },
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        // debugPrint(response.body);
        if (data.containsKey('places') && data['places'] is List) {
          List<PlaceElement> placesList = List.from(data['places'])
              .map((placeData) => PlaceElement.fromJson(placeData))
              .toList();

          HiveService().clearBox();
          HiveService().writeToBox('key1', Place(places: placesList));

          return placesList;
        } else {
          print('Invalid response format: places key not found or not a list.');
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      
      print('Exception: $e');
      throw e; 
    }

    
    return [];
  }
}
class SearchService {
  SearchService();

  Future<dynamic> searchText(double lat, double long, String text) async {
    String apiKey = Constants().getApiKey();
    String url = Constants().getSearchUrl();

    final headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': apiKey,
      'X-Goog-FieldMask': Constants().getParameters(),
    };

    final body = {
      'textQuery': text,
      "rankPreference": "DISTANCE",
      "locationBias": {
        "circle": {
          "center": {"latitude": lat, "longitude": long},
          "radius": 50000.0
        }
      }
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Print received data
        // debugPrint(response.body);

        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        // Handle error response
        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception: $e');
    }
  }
}
class NetworkManager {
  NetworkManager();

   Future<bool> checkInternetConnection(bool isInternetAvailable) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isInternetAvailable = true;
      }
    } on SocketException catch (_) {
      print('Not connected');
      isInternetAvailable = false;
    }
    return isInternetAvailable;
  }
}
class LocationManagerLatLong{
  LocationManagerLatLong();
  Future<List<double>> getCurrentLocation() async {
    try {
      var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<double> location = [
        position.latitude,
        position.longitude,
      ];
      return location;
    } catch (e) {
      // Handle exceptions
      print('Exception: $e');
      // You might want to return a default value or handle the exception in a meaningful way.
      return [];
    }
  }

}

