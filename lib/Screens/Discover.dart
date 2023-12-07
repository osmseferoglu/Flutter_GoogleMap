// ignore_for_file: avoid_print, file_names, non_constant_identifier_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/Screens/SubScreens/Drawer/DrawerView.dart';
import 'package:flutter_map/Screens/SubScreens/SeachScreen.dart';
import 'package:flutter_map/Screens/SubScreens/DetailView.dart';
import 'package:flutter_map/constants.dart';
import 'package:flutter_map/entity/Places/Places.dart';
import 'package:flutter_map/hive/Hive_Service.dart';
import 'package:flutter_map/repository/Services.dart';

class Discover extends StatefulWidget {
  const Discover({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  List<PlaceElement> placesArray = [];
  List<double> latLong = [];
  var searchTypeValue = 'cafe';

  bool isInternetAvailable = false;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    isLoading = true;
    isInternetAvailable = await NetworkManager().checkInternetConnection(isInternetAvailable);
    isInternetAvailable? _initialize() : _initializeHive();
    print(isInternetAvailable);
  }

  Future<void> _initialize() async {
    try {
      
       List<double> locValues =
          await LocationManagerLatLong().getCurrentLocation();
          setState(() {
            latLong = locValues;
          });
      

      setState(() {
        isLoading = true;
        
      });

      List<PlaceElement> places =
          await PlacesService().searchNearbyPlaces(latLong.first, latLong.last, searchTypeValue);

      setState(() {
        placesArray = places;
        isLoading = false;
       
      });
    } catch (error) {
      print('Error during initialization: $error');
    }
  }


  Future<void> _initializeHive() async {
    try {
      setState(() {
        isLoading = true;
      });

      List<PlaceElement> favorites = await HiveService().readFromBox();

      setState(() {
        isInternetAvailable = false;
        placesArray = favorites;
        isLoading = false;
      });
    } catch (error) {
      print('Error during initialization: $error');
    }
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
      body: RefreshIndicator(
        onRefresh: () async {
          _initializeMap();
        },
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: placesArray.length,
                itemBuilder: (context, index) {
                  if (placesArray[index].rating == null ||
                      placesArray[index].businessStatus ==
                          'TEMPORARLY CLOSED' ||
                      placesArray[index].photos.isEmpty) {
                    return Container(); 
                  }
                  return ListTile(
                    
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: 
                      placesArray[index].photos.isNotEmpty && isInternetAvailable == true ?
                      Image.network(
                          Constants().getThumbnailUrl(placesArray[index].photos[0].name)
                      ,
                        fit: BoxFit.fill,
                        width: 60,
                        height: 90,
                      ):Image.asset('assets/images/placeholder.png'),
                    ),
                    title: Text(
                      placesArray[index].displayName.text,
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      placesArray[index].formattedAddress,
                      maxLines: 2,
                    ),
                    trailing: const Icon(CupertinoIcons.chevron_forward),
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
      drawer: const Drawer(child: DrawerView()),
      floatingActionButton: FloatingActionButton.extended(
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
        )
      ),
    );
  }
}
