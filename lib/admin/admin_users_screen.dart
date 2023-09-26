import 'package:ev_admin_terminal/admin/admin_add_charger_screen.dart';
import 'package:ev_admin_terminal/admin/admin_add_station_screen.dart';
import 'package:ev_admin_terminal/admin/admin_side_bar.dart';
import 'package:ev_admin_terminal/admin/station_tapbar_screen.dart';
import 'package:ev_admin_terminal/admin/view_station_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen();

  @override
  _AdminUsersScreenState createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  _AdminUsersScreenState();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  CollectionReference notesRef = FirebaseFirestore.instance.collection("users");
  bool isEditing = false;
  var emailController = TextEditingController();
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var numberController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Users'
          ),
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
                  fnameController = TextEditingController(text: snapshot.data?.docs[index]['fname']);
                  lnameController = TextEditingController(text: snapshot.data?.docs[index]['lname']);
                  emailController = TextEditingController(text: snapshot.data?.docs[index]['email']);
                  numberController = TextEditingController(text: snapshot.data?.docs[index]['mobile']);
                  passwordController = TextEditingController(text: snapshot.data?.docs[index]['password']);

                  // String locationString = "${geoPoint.latitude}, ${geoPoint.longitude}";
                  // TextEditingController locationController = TextEditingController(text: locationString);

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
                                          'User Infomation:',
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
                                          'First Name:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: fnameController,
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
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Last Name:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: lnameController,
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
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'E-Mail:        ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: emailController,
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
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Number:     ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: numberController,
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
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Row(
                                  //     crossAxisAlignment: CrossAxisAlignment.center,
                                  //     children: [
                                  //       Text(
                                  //         'Password:  ',
                                  //         style: TextStyle(
                                  //           fontWeight: FontWeight.bold,
                                  //         ),
                                  //       ),
                                  //       SizedBox(width: 8.0),
                                  //       Expanded(
                                  //         child: TextFormField(
                                  //           controller: passwordController,
                                  //           obscureText: true,
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
                                                  updateUser(fnameController.text, lnameController.text, emailController.text, numberController.text);
                                                  setState(() {
                                                    isEditing = false;
                                                  });
                                                }
                                                    : null,
                                                style: ElevatedButton.styleFrom(
                                                  primary: isEditing ? Colors.blue : Colors.grey, // Change button color based on isEditing
                                                ),
                                                child: Container(
                                                  child: Text(
                                                    'Update User',
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
                                  ),

                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 45,
                                        width: 300,
                                        child: ElevatedButton(
                                          onPressed: isEditing
                                              ? () {
                                            // Perform button action here
                                            // updatePrice(snapshot.data!.docs[index].id, int.parse(priceController.text));

                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text('Delete User'),
                                                content: Text('Are you sure you want to delete this User?'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () => Navigator.pop(context),
                                                      child: Text('Cancel')
                                                  ),
                                                  TextButton(
                                                    child: Text('Delete'),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      deleteUser(snapshot.data!.docs[index].id);
                                                      setState(() {
                                                        isEditing = false;
                                                      });
                                                    },
                                                  )
                                                ],
                                              ),
                                            );
                                          }
                                              : null,
                                          style: ElevatedButton.styleFrom(
                                            primary: isEditing ? Colors.red : Colors.grey, // Change button color based on isEditing
                                          ),
                                          child: Container(
                                            child: Text(
                                              'Delete User',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
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

  void updateUser(String email, String fname, String lname, String number) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('chargers')
          .where('email', isEqualTo: email)
          .get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        await documentSnapshot.reference.update({
          'fname': fname,
          'lname': lname,
          'email': email,
          'mobile': number,
        });
      }

      print('User data updated successfully');
    } catch (error) {
      print('Error updating user data: $error');
    }
  }


  void deleteUser(docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(docId)
          .delete();

      print('User deleted successfully');
    } catch (error) {
      print('Error deleting user: $error');
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
