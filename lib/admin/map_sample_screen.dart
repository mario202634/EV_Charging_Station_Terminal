import 'dart:async';
import 'package:ev_admin_terminal/admin/admin_add_station_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class MapSample extends StatefulWidget {
  dynamic? name;
  dynamic? stationId;
  dynamic? email;
  dynamic? password;


  MapSample({this.name, this.stationId, this.email, this.password});

  @override
  _MapSampleState createState() => _MapSampleState(name, stationId, email, password);
}

class _MapSampleState extends State<MapSample> {
  dynamic name;
  dynamic stationId;
  dynamic email;
  dynamic password;

  _MapSampleState(this.name, this.stationId, this.email, this.password);

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.05057361352647, 31.2371783382212),
    zoom: 14.4746,
  );

  List<Marker> myMarker = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("name " + name);
    print("stationid " + stationId);
    print("email " + email);
    print("password " + password);
    customMarkers();
  }

  BitmapDescriptor cmarker = BitmapDescriptor.defaultMarker;

  void customMarkers() {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/images/2FinalStationMarker.png'
    ).then((icon) {
      cmarker = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map Screen"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Handle button press here
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminAddStationScreen(name: name, stationId: stationId, email: email, password: password, latlng: latlng,)),);
                print("LatLng tele3: $latlng");
                },
          ),
        ],
      ),

      body: GestureDetector(
        onTap: () {
          // Handle the onTap gesture here if needed
        },
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: Set.from(myMarker),
          // onTap: addMarker,
          onTap: (LatLng loc){
            print("5ara : $loc");
            addMarker(loc);
            setState(() {
              latlng = loc;
            });
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Handle the floating action button press here
      //     print("Hello World");
      //   },
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  dynamic latlng;
  addMarker(LatLng location){
    print(location);
    setState(() {
        myMarker = [];
        myMarker.add(
          Marker(
            markerId: MarkerId(location.toString()),
            position: location,
            icon: cmarker,
            draggable: true,
            onDragEnd: (dragEndPostion){
              print(dragEndPostion);
              setState(() {
                // latlng = location;
              });
            }
          ),
        );
    });
    print("ana location: " + location.toString());
    return location;
  }

}