import 'package:ev_admin_terminal/admin/admin_add_charger_screen.dart';
import 'package:ev_admin_terminal/admin/admin_add_station_screen.dart';
import 'package:ev_admin_terminal/admin/admin_side_bar.dart';
import 'package:ev_admin_terminal/admin/station_tapbar_screen.dart';
import 'package:ev_admin_terminal/admin/view_station_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminStationScreen extends StatefulWidget {
  const AdminStationScreen();

  @override
  _AdminStationScreenState createState() => _AdminStationScreenState();
}

class _AdminStationScreenState extends State<AdminStationScreen> {
  _AdminStationScreenState();
  int selectedButton = 1; // Initially no button is selected

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  CollectionReference notesRef = FirebaseFirestore.instance.collection("stations");


  @override
  Widget build(BuildContext context) {
    bool isButton1Selected = selectedButton == 1;
    bool isButton2Selected = selectedButton == 2;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Stations"),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.add),
      //       onPressed: () {
      //         // Handle button press here
      //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminAddStationScreen()),);
      //       },
      //     ),
      //   ],
      // ),
      //
      // drawer: AdminSideBar(),

      body: Column(
        children: [
        //   SizedBox(height: 20,),
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       ElevatedButton(
        //         onPressed: () {
        //           setState(() {
        //             selectedButton = 1;
        //           });
        //         },
        //         style: ElevatedButton.styleFrom(
        //           primary: isButton1Selected ? Colors.grey : Colors.blue,
        //         ),
        //         child: Text('Button 1'),
        //       ),
        //       SizedBox(width: 16.0),
        //       ElevatedButton(
        //         onPressed: () {
        //           setState(() {
        //             selectedButton = 2;
        //           });
        //         },
        //         style: ElevatedButton.styleFrom(
        //           primary: isButton2Selected ? Colors.grey : Colors.blue,
        //         ),
        //         child: Text('Button 2'),
        //       ),
        //     ],
        //   ),
      Expanded(
            child: StreamBuilder(
                stream: notesRef
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error");
                  }
                  try{
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // return Text("loding ....");
                      return CircularProgressIndicator();
                    }
                  }catch (error) {
                    return Text('An error occurred: $error');
                  }

                  if (snapshot.hasData) {              return ListView.builder(
                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 2, // Number of cards in each row
                    // ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      //return Text("${snapshot.data?.docs[index]['stationId']}");
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Container(
                                width: 400,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${snapshot.data?.docs[index]['name']}",
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.location_on),
                                        Text(
                                          "Location: ${snapshot.data?.docs[index]['location'].latitude.toString()}, ${snapshot.data?.docs[index]['location'].longitude.toString()}",
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            if (snapshot.data?.docs[index] != null) {
                                              // Perform the desired action
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => StationScreen(stationId: snapshot.data?.docs[index]['stationId'],),
                                                ),
                                              );
                                            }
                                            print("Available");
                                          },
                                          child: Text('View Station'),
                                        ),
                                        SizedBox(width: 40.0),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (snapshot.data?.docs[index] != null) {
                                              // Perform the desired action
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => AddChargerScreen(stationId: snapshot.data?.docs[index]['stationId']),
                                                ),
                                              );
                                            }

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
                                                  if (snapshot.data?.docs[index] != null) {
                                                    // Perform the desired action
                                                    deleteStation(snapshot.data?.docs[index]['stationId']);
                                                    deleteChargers(snapshot.data?.docs[index]['stationId']);
                                                    deleteReservation(snapshot.data?.docs[index]['stationId']);
                                                    deleteBooking(snapshot.data?.docs[index]['stationId']);
                                                    Navigator.pop(context);
                                                    setState(() {

                                                    });
                                                  }
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
                              ),
                            ),
                          ),
                        ],
                      );

                    },
                  );

                  }
                  if (!snapshot.hasData){
                    return Text("No Data");
                  }
                  return Text("No Data 5ales");
                }),
          ),
        ],
      ),
    );
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

  Future<void> deleteChargers(String stationId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('chargers')
          .where('stationId', isEqualTo: stationId)
          .get();

      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }

      print('Charger deleted successfully');
    } catch (error) {
      print('Error deleting documents: $error');
    }
  }

  // Future<void> deleteReservation(String sid) async {
  //   try {
  //     final CollectionReference collectionRef = await FirebaseFirestore.instance.collection('chargers');
  //     dynamic snapshot = await collectionRef.doc(sid).get();
  //     final String stationId = snapshot.data()!['stationId'];
  //
  //     QuerySnapshot snapshot2 = await FirebaseFirestore.instance
  //         .collection('reservations')
  //         .where('stationId', isEqualTo: stationId)
  //         .get();
  //
  //     for (DocumentSnapshot doc in snapshot.docs) {
  //       await doc.reference.delete();
  //     }
  //
  //     print('Documents deleted successfully');
  //   } catch (error) {
  //     print('Error deleting documents: $error');
  //   }
  // }

  void deleteReservation(String sid) {
    final CollectionReference chargersCollection =
    FirebaseFirestore.instance.collection('chargers');

    chargersCollection
        .where('stationId', isEqualTo: sid)
        .get()
        .then((QuerySnapshot snapshot) async { // Add async keyword here
      if (snapshot.docs.isNotEmpty) {
        // Found a matching document
        DocumentSnapshot document = snapshot.docs[0];
        String documentId = document.id;
        // Print the document ID and other information
        print('Charger Document ID: $documentId');
        print('Charger Data: ${document.data()}');

        try {
          QuerySnapshot snapshot2 = await FirebaseFirestore.instance
              .collection('reservations')
              .where('chargerId', isEqualTo: documentId)
              .get();

          for (DocumentSnapshot doc in snapshot2.docs) { // Use snapshot2 here
            await doc.reference.delete();
          }

          print('Reservation deleted successfully');
        } catch (error) {
          print('Error deleting documents: $error');
        }
      } else {
        // No matching document found
        print('No charger document found for station ID: $sid');
      }
    }).catchError((error) {
      // Handle any errors that occur
      print('Error retrieving charger document ID: $error');
    });
  }

  void deleteBooking(String sid) {
    final CollectionReference chargersCollection =
    FirebaseFirestore.instance.collection('chargers');

    chargersCollection
        .where('stationId', isEqualTo: sid)
        .get()
        .then((QuerySnapshot snapshot) async { // Add async keyword here
      if (snapshot.docs.isNotEmpty) {
        // Found a matching document
        DocumentSnapshot document = snapshot.docs[0];
        String documentId = document.id;
        // Print the document ID and other information
        print('Charger Document ID: $documentId');
        print('Charger Data: ${document.data()}');

        try {
          QuerySnapshot snapshot2 = await FirebaseFirestore.instance
              .collection('bookings')
              .where('serviceId', isEqualTo: documentId)
              .get();

          for (DocumentSnapshot doc in snapshot2.docs) { // Use snapshot2 here
            await doc.reference.delete();
          }

          print('Booking deleted successfully');
        } catch (error) {
          print('Error deleting documents: $error');
        }
      } else {
        // No matching document found
        print('No charger document found for station ID: $sid');
      }
    }).catchError((error) {
      // Handle any errors that occur
      print('Error retrieving charger document ID: $error');
    });
  }


}
