// ignore_for_file: file_names, avoid_print, unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/Screens/SubScreens/DetailView.dart';
import 'package:flutter_map/Screens/SubScreens/Drawer/DrawerView.dart';
import 'package:flutter_map/constants.dart';

import 'package:flutter_map/entity/Places/Places.dart';

import 'package:flutter_map/hive/Hive_Service.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<PlaceElement> _favorites = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

 
  Future<void> _initializeHive() async {
    try {
      List<PlaceElement> favorites = await HiveService().getFavorites();
      
      setState(() {
        print(favorites);
        _favorites = favorites;
        _isLoading = false;
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
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildFavoritesList(),
      drawer: const DrawerView(),
    );
  }

  Widget _buildFavoritesList() {
    return ListView.builder(
      itemCount: _favorites.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(_favorites[index].id),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            
            setState(() {
              _favorites.removeAt(index);
              HiveService().deleteFavorite(_favorites[index].id);
            });
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding:  const EdgeInsets.symmetric(horizontal: 20),
            child:  const Icon(
              CupertinoIcons.trash,
              color: Colors.white,
            ),
          ),
          child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _favorites[index].photos.isNotEmpty?
                      Image.network(
                          Constants().getThumbnailUrl(_favorites[index].photos[0].name),
                        fit: BoxFit.fill,
                        width: 60,
                        height: 90,
                      ): Image.asset('assets/images/placeholder.png')
                    ),
                    title: Text(_favorites[index].displayName.text,maxLines: 1),
                    subtitle: Text(_favorites[index].formattedAddress,maxLines: 2,),
                    trailing: const Icon(CupertinoIcons.chevron_forward),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailView(
                            placeElement: _favorites[index],
                            isfav: true,
                          ),
                        ),
                      )
                    },
                  
          
          ),
        );
      },
    );
  }
}
