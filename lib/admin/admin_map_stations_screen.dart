import 'dart:math' as math;
import 'package:ev_admin_terminal/admin/admin_add_charger_screen.dart';
import 'package:ev_admin_terminal/admin/station_tapbar_screen.dart';
import 'package:ev_admin_terminal/admin/view_station_screen.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TestingScreen extends StatefulWidget {
  const TestingScreen({Key? key}) : super(key: key);

  @override
  _TestingScreenState createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  Map<String, Marker> dbmarkers = <String, Marker>{};

  late GoogleMapController googleMapController;
  // static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);
  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(30.0444, 31.2357), zoom: 14.8);
  late BitmapDescriptor markerIcon;
  Set<Marker> markers = {};
  // final user = FirebaseAuth.instance.currentUser!;
  Set<String> allMarkerId = {};
  CollectionReference notesRef = FirebaseFirestore.instance.collection("chargers");

  final lat1 = 37.7749;
  final lon1 = -122.4194;
  final lat2 = 40.7128;
  final lon2 = -74.0060;
  final speed = 30.0; // km/h

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
  void initState() {
    // TODO: implement initState
    //_determinePosition();
    customMarkers();
    getMarkerData();
    final distance = calculateDistance(lat1, lon1, lat2, lon2);
    final time = calculateTime(distance, speed * 1000.0 / 3600.0);
    print('Distance: ${distance.toStringAsFixed(2)} meters');
    print('Time: ${time.toStringAsFixed(2)} minutes');
    super.initState();
  }


  void initMarker(data, dataid) async {
    var markerIdVal = dataid;
    final MarkerId markerId = MarkerId(markerIdVal);
    print("Documents init");
    final Marker marker = await Marker(
        markerId: markerId,
        position: LatLng(data['location'].latitude, data['location'].longitude),
        consumeTapEvents: true, // prevent re-centering when tapped
        //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        icon: cmarker,
        onTap: () async {
          _tripEditModalBottomSheet(context, data);
          getAvailChargers(data);
          getChargersTypes(data);
          print("Marker clicked");
        }
    );
    setState(() {
      dbmarkers[dataid] = marker;
    });

  }

  getMarkerData() {
    FirebaseFirestore.instance.collection("stations").get().then((docs) {
      if (docs.docs.isNotEmpty) {
        print("Documents exist");
        for (int i = 0; i < docs.docs.length; i++) {
          //initMarker(docs.docs[i].data(), docs.docs[i].id);
          initMarker(docs.docs[i].data(), docs.docs[i].data()['stationId']);

          print(docs.docs[i].data().toString());
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        //markers: markers,
        markers: Set<Marker>.of(dbmarkers.values),
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),

    );

  }

  void _tripEditModalBottomSheet(context, param1) {
    showModalBottomSheet(context: context, builder: (BuildContext bc) {
      return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                //Name + Cancel
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        param1["name"],
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )
                    ),
                  ],
                ),

                Divider(
                  indent: 15,
                  endIndent: 15,
                  height: 20,
                  thickness: 2,
                ),

                //Chargers Information
                Column(
                  children: [
                    SizedBox(height: 5.0),

                    Text("Chargers Information"),

                    SizedBox(height: 15.0),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.all(11),
                            child: FutureBuilder<String>(
                              future: getAvailChargers(param1),
                              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Text('Loading...');
                                }
                                print('Avaiable Chargers: ${snapshot.data}');
                                return Text('Avaiable Chargers: ${snapshot.data}');
                                return Text('Location: N/A');
                              },
                            ),
                          ),
                        ),
                        //Text(getAvailChargers(param1).toString()),
                        SizedBox(height: 15),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.all(10),
                            child: FutureBuilder<String>(
                              future: getChargersTypes(param1),
                              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Text('Loading...');
                                }
                                print('Chargers Type: ${snapshot.data}');
                                return Text('Chargers Type: ${snapshot.data}');
                                return Text('Location: N/A');
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // SizedBox(height: 20,),


                Divider(
                  indent: 300,
                  endIndent: 300,
                  height: 20,
                  thickness: 2,
                ),

                // View Station Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                          // Perform the desired action
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StationScreen(stationId: param1['stationId'],),
                            ),
                          );
                        print("Available");
                      },
                      child: Text('View Station'),
                    ),
                    SizedBox(width: 40.0),
                    ElevatedButton(
                      onPressed: () {
                          // Perform the desired action
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddChargerScreen(stationId: param1['stationId']),
                            ),
                          );
                        print("Available");
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Set the background color to red
                      ),
                      child: Text('Add Charger'),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Delete'),
                        content: Text('Are you sure you want to delete this Station?'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancel')
                          ),
                          TextButton(
                            child: Text('Delete'),
                            onPressed: () {
                                // Perform the desired action
                                deleteStation(param1['stationId']);
                                Navigator.pop(context);
                                setState(() {

                                });
                              print("Available");
                            },
                          )
                        ],
                      ),
                    );

                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Set the background color to red
                  ),
                  child: Text('Delete Station'),
                ),
              ],
            ),
          )
      );
    });
  }

  Future<void> deleteStation(String stationId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('stations')
          .where('stationId', isEqualTo: stationId)
          .get();

      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }

      print('Station deleted successfully');
    } catch (error) {
      print('Error deleting documents: $error');
    }
  }

// Calculates the distance (in meters) between two coordinates
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371000.0; // Earth's radius in meters
    final phi1 = lat1 * math.pi / 180.0;
    final phi2 = lat2 * math.pi / 180.0;
    final deltaPhi = (lat2 - lat1) * math.pi / 180.0;
    final deltaLambda = (lon2 - lon1) * math.pi / 180.0;

    final a = math.sin(deltaPhi / 2.0) * math.sin(deltaPhi / 2.0) +
        math.cos(phi1) * math.cos(phi2) *
            math.sin(deltaLambda / 2.0) * math.sin(deltaLambda / 2.0);

    final c = 2.0 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    final distance = R * c;

    return distance / 1000;
  }

// Calculates the time (in minutes) to travel a certain distance (in meters)
  int calculateTime(double distance, double speed) {
    final timeInSeconds = (distance * 1000) / speed;
    final timeInMinutes = timeInSeconds / 60.0;

    if(timeInMinutes < 1)
    {
      return 1;
    }
    int minutes = timeInMinutes.ceil();
    return minutes;
  }


  dynamic ai7aga;
  Future<String> getAvailChargers(data) async {
    await FirebaseFirestore.instance.collection('chargers')
        .where('stationId', isEqualTo: data['stationId'])
        .where('active', isEqualTo: false)
        .get()
        .then((docs) {
      setState(() {
        ai7aga = docs.docs.length.toString();
        print(ai7aga);
        print("Ai7aga awel");
        return;
      });

      if (docs.docs.isNotEmpty) {
        print("Free found: \n");
        for (int i = 0; i < docs.docs.length; i++) {
          print("Charger: " + (i + 1).toString());
          ai7aga = (i + 1).toString();
          print(ai7aga);
          print("Fo2i ai 7aga");
          setState(() {
            ai7aga = docs.docs.length.toString();
            print(ai7aga);
            print("Ai7aga for");
            return;
          });
        }
        setState(() {
          ai7aga = docs.docs.length.toString();
          print(ai7aga);
          print("Ai7aga if");
          return;
        });
      }
      if (docs.docs.isEmpty) {
        // return "0"; //shady
        print("No Free found: \n");
        for (int i = 0; i < docs.docs.length; i++) {
          print("Charger: " + (i + 1).toString());
        }
        setState(() {
          ai7aga = docs.docs.length.toString();
          print(ai7aga);
          print("Ai7aga if 2");
          return;
        });
      }
      setState(() {
        ai7aga = docs.docs.length.toString();
        print(ai7aga);
        print("Ai7aga tani");
        return;
      });
    }
    );
    return ai7aga;
  }

  List<String> ai7aga2 = [];
  dynamic result;
  Future<String> getChargersTypes(data) async {
    await FirebaseFirestore.instance.collection('chargers')
        .where('stationId', isEqualTo: data['stationId'])
    // .distinct()
        .get()
        .then((docs) {
      ai7aga2 = [];
      for (int i = 0; i < docs.docs.length; i++) {
        // print("Charger: " + (i + 1).toString());
        // ai7aga = (i + 1).toString();
        if(ai7aga2.contains(docs.docs[i].data()['type'].toString()))
        {
          return;
        }
        if(!ai7aga2.contains(docs.docs[i].data()['type'].toString()))
        {
          ai7aga2.add(docs.docs[i].data()['type'].toString());
        }
        print(ai7aga2.toString());
        print("Fo2i ai7aga2");
        // String result = ai7aga2.join(', ');
        // print(result); // prints "1, 2, 3"
        setState(() {
          print("Charger Types downwoards");
          // ai7aga2.add(docs.docs[i].data()['type'].toString());
          result = ai7aga2.join(', ');
          print(result);
          print("Charger Types above");
          return;
        });
      }
      setState(() {
        print("2 Charger Types downwoards");
        // ai7aga2.add(docs.docs[i].data()['type'].toString());
        result = ai7aga2.join(', ');
        print(result);
        print("2 Charger Types above");
        return;
      });
    }
    );
    print("Result: " + result.toString());
    return result;
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
}
