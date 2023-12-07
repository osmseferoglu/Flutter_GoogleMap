// ignore_for_file: avoid_print, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/Screens/SubScreens/Drawer/DrawerView.dart';
import 'package:flutter_map/Screens/SubScreens/SeachScreen.dart';
import 'package:flutter_map/entity/Places/Places.dart';
import 'package:flutter_map/repository/Services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.title});
  final String title;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<PlaceElement> placesArray = [];
  List<double> latLong = [];
  GoogleMapController? mapController;

  var searchTypeValue = 'cafe';
  
  bool isInternetAvailable = false;
  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
   
    isInternetAvailable = await NetworkManager().checkInternetConnection(isInternetAvailable);
     List<double> locValues =
        await LocationManagerLatLong().getCurrentLocation();
    
    setState(() {
      
      latLong = locValues;
    });
    List<PlaceElement> places = await PlacesService()
        .searchNearbyPlaces(latLong.first, latLong.last, searchTypeValue);
        setState(() {
          placesArray = places;
        });
    _moveToCurrentLocation();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              child: isInternetAvailable
                  ? const Icon(
                      CupertinoIcons.wifi,
                      color: Colors.blueAccent,
                    )
                  : const Icon(
                      CupertinoIcons.wifi_slash,
                      color: Colors.red,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(
                      (context),
                      MaterialPageRoute(
                          builder: (context) =>  SearchScreen(late: latLong.first,long: latLong.last,
                                title: 'Search',)));
                });
              },
              child: const Icon(CupertinoIcons.search),
            ),
          ),
        ],
      ),
      body: 
      GoogleMap(
        buildingsEnabled: false,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
        target: LatLng(latLong.first, latLong.last),
        zoom: 15,
      ),
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
        _moveToCurrentLocation();
      },
      
      markers: _createMarkers(),
      ),
      drawer: const Drawer(child: DrawerView(),),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () {
          if (isInternetAvailable) {
            setState(() {
              searchTypeValue == 'cafe'
                  ? searchTypeValue = 'restaurant'
                  : searchTypeValue = 'cafe';
              _initializeMap();
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Network Error."),
                backgroundColor: Colors.purple,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
      
        label: SizedBox(
          width: 75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
            searchTypeValue == 'cafe'
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.local_cafe),
                      Text(searchTypeValue)
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.restaurant),
                      Text(searchTypeValue)
                    ],
                  ),
          ]),
        ),
      ),
    );

  }

   void _moveToCurrentLocation() {
    if (mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLng(LatLng(latLong.first, latLong.last)),
      );
    }
  }


  Set<Marker> _createMarkers() {
    return placesArray.map((placeElement) {
      return Marker(
        markerId: MarkerId(placeElement.id),
        position: LatLng(
          placeElement.location.latitude,
          placeElement.location.longitude,
        ),
        infoWindow: InfoWindow(
          title: placeElement.displayName.text,
        ),
      );
    }).toSet();
  }

}