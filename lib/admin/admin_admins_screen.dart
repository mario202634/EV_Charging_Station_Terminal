import 'package:ev_admin_terminal/admin/admin_add_charger_screen.dart';
import 'package:ev_admin_terminal/admin/admin_add_station_screen.dart';
import 'package:ev_admin_terminal/admin/admin_side_bar.dart';
import 'package:ev_admin_terminal/admin/station_tapbar_screen.dart';
import 'package:ev_admin_terminal/admin/view_station_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminAdminsScreen extends StatefulWidget {
  const AdminAdminsScreen();

  @override
  _AdminAdminsScreenState createState() => _AdminAdminsScreenState();
}

class _AdminAdminsScreenState extends State<AdminAdminsScreen> {
  _AdminAdminsScreenState();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  CollectionReference notesRef = FirebaseFirestore.instance.collection("admins");
  bool isEditing = false;
  var emailController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Admins"),
          centerTitle: true,
        ),


        drawer: AdminSideBar(),
        body: StreamBuilder(
          stream: notesRef.snapshots(),
          builder: (context, snapshot) {
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
                  emailController = TextEditingController(text: snapshot.data?.docs[index]['email']);
                  nameController = TextEditingController(text: snapshot.data?.docs[index]['Full Name']);

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
                                          // 'Charger: ${index + 1}',
                                          'Admin Information',
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
                                          'Admin Name:  ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: nameController,
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


                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Admin E-Mail:  ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: emailController,
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

  void updatePrice(String docId, int newPrice) async {
    try {
      await FirebaseFirestore.instance
          .collection('chargers')
          .doc(docId)
          .update({'price': newPrice});
      print('Price updated successfully');
    } catch (error) {
      print('Error updating price: $error');
    }
  }


  String yourTextVariable = '';

  getStationName(stationId) async {
    FirebaseFirestore.instance.collection('stations')
        .where('stationId', isEqualTo: stationId)
        .get()
        .then((docs) {
      print("Documents");
      print(docs.toString());
      if(docs.docs.isNotEmpty)
      {
        setState(() {
          yourTextVariable = docs.docs[0].data()['name'];
          //   print("Station: ");
          //   print(stationName.toString());
        });
      }
    }
    );
  }




}
