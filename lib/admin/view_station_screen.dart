import 'package:ev_admin_terminal/admin/admin_side_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:hexcolor/hexcolor.dart';

class ViewStationScreen extends StatefulWidget {
  final dynamic stationId;

  const ViewStationScreen({this.stationId});

  @override
  _ViewStationScreenState createState() => _ViewStationScreenState(stationId);
}

class _ViewStationScreenState extends State<ViewStationScreen> {
  final dynamic stationId;
  bool isEditing = false;
  _ViewStationScreenState(this.stationId);
  CollectionReference notesRef = FirebaseFirestore.instance.collection("stations");
  var nameController = TextEditingController();
  var locationController = TextEditingController();
  var stationIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: StreamBuilder(
          stream: notesRef.where('stationId', isEqualTo: stationId).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.data?.docs.length == 0)
            {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Center(
                    child: Text(
                      'No Stations found',
                      style: TextStyle(
                        fontSize: 14,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return Text("Error");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading...");
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  TextEditingController nameController = TextEditingController(text: snapshot.data?.docs[index]['name']);
                  TextEditingController stationIdController = TextEditingController(text: snapshot.data?.docs[index]['stationId']);
                  GeoPoint geoPoint = snapshot.data?.docs[index]['location'];
                  String locationString = "${geoPoint.latitude}, ${geoPoint.longitude}";
                  TextEditingController locationController = TextEditingController(text: locationString);

                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(100.0,20.0,100.0,20.0,),
                      child: SizedBox(
                        child: Container(
                          width: 500,
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
                          child: Center(
                            child: Container(
                              width: 500,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Station Infomation:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Name:      ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: nameController,
                                            enabled: isEditing,
                                            keyboardType: TextInputType.text,
                                            onFieldSubmitted: (value) {
                                              print(value);
                                            },
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              prefixIcon: Icon(Icons.account_circle_outlined),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Loction:   ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: locationController,
                                            enabled: false,
                                            keyboardType: TextInputType.text,
                                            onFieldSubmitted: (value) {
                                              print(value);
                                            },
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              prefixIcon: Icon(Icons.account_circle_outlined),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Row(
                                  //     crossAxisAlignment: CrossAxisAlignment.center,
                                  //     children: [
                                  //       Text(
                                  //         'StationId:',
                                  //         style: TextStyle(
                                  //           fontWeight: FontWeight.bold,
                                  //         ),
                                  //       ),
                                  //       SizedBox(width: 8.0),
                                  //       Expanded(
                                  //         child: TextFormField(
                                  //           controller: stationIdController,
                                  //           enabled: false,
                                  //           keyboardType: TextInputType.text,
                                  //           onFieldSubmitted: (value) {
                                  //             print(value);
                                  //           },
                                  //           decoration: InputDecoration(
                                  //             border: OutlineInputBorder(),
                                  //             prefixIcon: Icon(Icons.account_circle_outlined),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // Other form fields for other attributes
                                  Row(
                                    children: [
                                      Expanded(
                                        child: buildSwitch(),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 45,
                                              width: 300,
                                              child: ElevatedButton(
                                                onPressed: isEditing
                                                    ? () {
                                                  // Perform button action here
                                                  updatePrice(snapshot.data!.docs[index].id, nameController.text);
                                                  setState(() {
                                                    isEditing = false;
                                                  });
                                                }
                                                    : null,
                                                style: ElevatedButton.styleFrom(
                                                  primary: isEditing ? Colors.purple : Colors.grey, // Change button color based on isEditing
                                                ),
                                                child: Container(
                                                  child: Text(
                                                    'Update Station',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )

                                ],
                              ),
                            ),

                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Text('No data available');
          },
        )
    );
  }
  Widget buildSwitch() => Switch.adaptive(
    value: isEditing,
    onChanged: (value) => setState(() => isEditing = value),
  );

  void updatePrice(String docId, String newName) async {
    try {
      await FirebaseFirestore.instance
          .collection('stations')
          .doc(docId)
          .update({'name': newName});
      print('Name updated successfully');
    } catch (error) {
      print('Error updating Name: $error');
    }
  }

}
