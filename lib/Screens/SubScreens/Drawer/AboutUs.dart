// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About us'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal:90.0,vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              child: FlutterLogo(size: 100,),
            ),
            SizedBox(height: 16),
            Text(
              'Graduation Project',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Made with ❤️ by \nOsman Seferoğlu',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
         
          ],
        ),
      ),
    );
  }
}
