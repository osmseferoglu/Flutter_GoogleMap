// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'AboutUs.dart';
import 'Profile.dart';


class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
         const UserAccountsDrawerHeader(accountName: Text("Osman Seferoğlu"), accountEmail: Text("Flutter Map"),currentAccountPicture: CircleAvatar(backgroundImage: AssetImage("assets/images/47645376.png"),
         )),
         
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              // Handle item 1 tap
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
            },
          ),
          ListTile(
            title: const Text('About us'),
            onTap: () {
              // Handle item 2 tap
              Navigator.pop(context); // Close the drawe
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const AboutUs()));
            },
          ),
          
         
          // Add more items as needed
        ],
      ),
      
    );
  }
}
