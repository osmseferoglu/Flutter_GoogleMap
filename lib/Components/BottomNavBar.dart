// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/Screens/Discover.dart';

import 'package:flutter_map/Screens/MapScreen.dart';
import 'package:flutter_map/Screens/Favorites.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  
  var PageList = [const Discover(title: 'Discover',)
  ,const MapScreen(title: "Map"), const Favorites(title: 'Favorites')];
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: PageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.purple,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.location_fill),
              label: "Discover"),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.map_fill), label: "Map"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart_fill), label: "Favorites",),
              
        ],
      ),
     
    );
  }
}
