import 'package:flutter/material.dart';
import 'package:flutter_map/Components/BottomNavBar.dart';
import 'package:flutter_map/entity/Places/Places.dart';

import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
   await Hive.initFlutter();
  Hive.registerAdapter(PlaceAdapter());
  Hive.registerAdapter(PlaceElementAdapter());
  Hive.registerAdapter(DisplayNameAdapter());
  Hive.registerAdapter(PhotoAdapter());
  Hive.registerAdapter(LocationAdapter());
  Hive.registerAdapter(AuthorAttributionAdapter());
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      
      debugShowCheckedModeBanner: false,
      
      home: BottomNavBar(),
    );
    
}
}