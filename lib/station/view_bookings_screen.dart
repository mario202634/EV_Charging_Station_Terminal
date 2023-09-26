import 'package:ev_admin_terminal/admin/admin_side_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewBookingsScreen extends StatefulWidget {
  final dynamic stationId;

  const ViewBookingsScreen({this.stationId});

  @override
  _ViewBookingsScreenState createState() => _ViewBookingsScreenState(stationId);
}

class _ViewBookingsScreenState extends State<ViewBookingsScreen> {
  final dynamic stationId;
  bool isEditing = false;
  _ViewBookingsScreenState(this.stationId);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  CollectionReference notesRef = FirebaseFirestore.instance.collection("reservations");
  var chargerIdController = TextEditingController();
  var userController = TextEditingController();
  var uidController = TextEditingController();
  var mailController = TextEditingController();
  var phoneController = TextEditingController();
  var startController = TextEditingController();
  var endController = TextEditingController();
  var durationController = TextEditingController();
  var priceController = TextEditingController();

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
                      'No Bookings found',
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
                  // bool isActive = snapshot.data?.docs[index]['active'] ?? false;

                  TextEditingController chargerIdController = TextEditingController(text: snapshot.data?.docs[index]['chargerId']);
                  TextEditingController userController = TextEditingController(text: snapshot.data?.docs[index]['userName']);
                  TextEditingController uidController = TextEditingController(text: snapshot.data?.docs[index]['userId']);
                  TextEditingController mailController = TextEditingController(text: snapshot.data?.docs[index]['userEmail']);
                  TextEditingController phoneController = TextEditingController(text: snapshot.data?.docs[index]['userPhoneNumber']);
                  TextEditingController startController = TextEditingController(text: snapshot.data?.docs[index]['bookingStart']);
                  TextEditingController endController = TextEditingController(text: snapshot.data?.docs[index]['bookingEnd']);
                  TextEditingController durationController = TextEditingController(text: (snapshot.data?.docs[index]['serviceDuration'] ?? 0).toString());
                  TextEditingController priceController = TextEditingController(text: ((snapshot.data?.docs[index]['servicePrice'] * (snapshot.data?.docs[index]['serviceDuration']/60)) ?? 0).toString());
                  String dropdownValue = ''; // Variable to store the selected value from the dropdown
                  bool paid = snapshot.data?.docs[index]['paid'] ?? false; // Retrieve the boolean value
                  print(chargerIdController);
                  print(userController);
                  print(uidController);
                  print(mailController);
                  print(phoneController);
                  print(startController);
                  print(endController);
                  print(durationController);
                  print(priceController);


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
                                          'Booking Information',
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
                                          'Charger Id:         ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: chargerIdController,
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
                                          'User Name:  ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: userController,
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
                                          'User ID:  ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: uidController,
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
                                          'User E-Mail: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: mailController,
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'User Phone:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: phoneController,
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
                                          'Start Time:  ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: startController,
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
                                          'End Time:  ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: endController,
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
                                          'Cost (in EGP):  ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: priceController,
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
                              DropdownButton<String>(
                                value: dropdownValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                  // Update the value in Firebase based on the selected option
                                  // You can add the code to update Firebase here
                                },
                                items: <String>['True', 'False'].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
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
                                                  // updatePrice(snapshot.data!.docs[index].id, int.parse(priceController.text));

                                                  showDialog(
                                                    context: context,
                                                    builder: (context) => AlertDialog(
                                                      title: Text('Delete Booking'),
                                                      content: Text('Are you sure you want to delete this Booking?'),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () => Navigator.pop(context),
                                                            child: Text('Cancel')
                                                        ),
                                                        TextButton(
                                                          child: Text('Delete'),
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                            deleteBooking(snapshot.data!.docs[index].id);
                                                            deleteReservation(snapshot.data!.docs[index].id);
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
                                                    'Delete Booking',
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


  deleteReservation(String docid) async {
    try {
      await FirebaseFirestore.instance
          .collection('reservations')
          .doc(docid)
          .delete();
      print('Document deleted successfully');
    } catch (error) {
      print('Error deleting document: $error');
    }
  }


  deleteBooking(String docid) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(docid)
          .delete();
      print('Document deleted successfully');
    } catch (error) {
      print('Error deleting document: $error');
    }
  }



}
