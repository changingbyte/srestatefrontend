import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/AppColors.dart';

class MapScreenUI extends StatefulWidget {
  var lat;
  var long;
  MapScreenUI({this.lat = 21.1702, this.long = 72.8311});

  @override
  State<MapScreenUI> createState() => _MapScreenUIState();
}

class _MapScreenUIState extends State<MapScreenUI> {
  Set<Marker> _marker ={};

  void onMapCreated(GoogleMapController googleMapController){
    setState(() {
      _marker.add(Marker(markerId: MarkerId("id-1"),position: LatLng(widget.lat,widget.long)),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_outlined)),
            title: Text("Estate Location"),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryColor,
                      Colors.black,
                    ]),
              ),
            ),
          ),
          body: GoogleMap(
              onMapCreated: onMapCreated,
              markers: _marker,
              initialCameraPosition:
              CameraPosition(
                target:LatLng(widget.lat,widget.long),
                zoom: 11,
              )),
        ));
  }
}
