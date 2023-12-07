// ignore_for_file: unused_element, deprecated_member_use, file_names, avoid_print

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/entity/Places/Places.dart';
import 'package:flutter_map/hive/Hive_Service.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailView extends StatefulWidget {
  final PlaceElement placeElement;
  final bool isfav;


  const DetailView({Key? key, required this.placeElement, required this.isfav}) : super(key: key);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  GoogleMapController? mapController;
  _launchCaller(String phoneNumber) async {
    String urlString = 'tel:$phoneNumber';
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      throw 'failed to launch: $urlString';
    }
  }
  @override
  void initState() {
    super.initState();
    
  }
  

  var isFaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _buildImageSlider(),
            _buildAboutSection(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      title:Text(
              widget.placeElement.displayName.text,
              style: const TextStyle(color: Colors.white),
            )
         ,
         actions: [
          !isFaved? 
          Row(
          children: [
            IconButton.filled(onPressed: (){
              setState(() {
                HiveService().addToFavorites(widget.placeElement);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Added To Favorites"),
                      backgroundColor: Colors.purple,
                      duration: Duration(seconds: 2),
                      
                    ),
                  );
                  isFaved =!isFaved;
              });
            }, icon:  Icon(CupertinoIcons.heart_fill,color: isFaved? Colors.red : Colors.white,)),
         ]):Container()],
      
    );
  }

  Widget _buildImageSlider() {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 380,
      width: screenWidth,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(),
        itemCount: widget.placeElement.photos.length,
       
        itemBuilder: (context, index) =>
       
            _buildImageSliderItem(index, screenWidth),
        
      ),
    );
  }

  Widget _buildImageSliderItem(int index, double screenWidth) {
    return SizedBox(
      height: 380,
      width: screenWidth,
      child: Stack(
        children: [
          Image.network(
            'https://places.googleapis.com/v1/${widget.placeElement.photos[index].name}/media?key=AIzaSyD1tXUuJTZC5eyV_69FtNM1jhqNIBJ4JhY&max_height_px=600',
            fit: BoxFit.cover,
            height: 400,
            width: screenWidth,
            scale: 2.5,
          ),
          if (index == 0) ...[
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 1,
                sigmaY: 1,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            
            Positioned(
              bottom: 45,
              child: _buildImageTextOverlay(),
            ),
            Positioned(
              bottom: 10,
              child: _buildRatingBar(),
            ),
          ],
          
        ],
      ),
    );
  }


  Widget _buildImageTextOverlay() {
    return SizedBox(
      height: widget.placeElement.displayName.text.length > 25 ? 100 : 55,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.placeElement.displayName.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildRatingBar() {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            
            
            
            for (double i = 0; i < widget.placeElement.rating!.round(); i++)
              const Icon(CupertinoIcons.star_fill, color: Colors.yellow),
              const SizedBox(width: 10),
           Text(
              widget.placeElement.rating.toString(),
              maxLines: 2,
              softWrap: true,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Text('(${widget.placeElement.userRatingCount.toString()})',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          ],
          
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
              
              const Text("Current Status",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      )),
              Text(
                widget.placeElement.businessStatus == "OPERATIONAL"
                    ? "Operational"
                    : "Temoorarily Closed",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    ),
              ),
              ],
              )
            ],
          ),
        ),
        
        _buildPhoneNumberSectionItem(),
        _buildAddressSectionItem(),
        const Row(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
            Text(
              "Map",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  ),
            )
          ],
        ),
        ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              
              height: 250,
              width: MediaQuery.of(context).size.width - 10,
              child: _buildMapView(),
            )),
      ],
    );
  }

  Widget _buildAddressSectionItem() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                    "Address",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        ),
                  ),
                ],
              ),
              Text(
                widget.placeElement.formattedAddress,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    ),
                softWrap: true,
              )
            ],
          ),
        ));
  }

  Widget _buildPhoneNumberSectionItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Phone Number",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          )),
                  Text(
                    widget.placeElement.nationalPhoneNumber ??
                        "No Phone Number",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                    softWrap: true,
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _launchCaller(
                        widget.placeElement.nationalPhoneNumber ?? '0');
                  });
                },
                icon: const Icon(
                  CupertinoIcons.phone_fill,
                  size: 30,
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildMapView() {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 400,
      width: screenWidth,
      child: GoogleMap(
        mapType: MapType.normal,
        mapToolbarEnabled: true,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            mapController = controller;
            _moveToCurrentLocation();
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.placeElement.location.latitude,
            widget.placeElement.location.longitude,
          ),
          zoom: 15.5,
        ),
        markers: _createMarkers(),
      ),
    );
  }
   void _moveToCurrentLocation() {
    if (mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLng(LatLng(widget.placeElement.location.latitude, widget.placeElement.location.longitude)),
      );
    }
  }

  Set<Marker> _createMarkers() {
    return {
      Marker(
        markerId: MarkerId(widget.placeElement.id),
        position: LatLng(
          widget.placeElement.location.latitude,
          widget.placeElement.location.longitude,
        ),
        infoWindow: InfoWindow(
          title: widget.placeElement.displayName.text,
        ),
      ),
    };
  }
  
  
}
