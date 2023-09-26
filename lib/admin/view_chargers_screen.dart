import 'package:ev_admin_terminal/admin/admin_side_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ViewChargersScreen extends StatefulWidget {
  final dynamic stationId;

  const ViewChargersScreen({this.stationId});

  @override
  _ViewChargersScreenState createState() => _ViewChargersScreenState(stationId);
}

class _ViewChargersScreenState extends State<ViewChargersScreen> {
  final dynamic stationId;
  bool isEditing = false;
  _ViewChargersScreenState(this.stationId);
  CollectionReference notesRef = FirebaseFirestore.instance.collection("chargers");
  var activeController = TextEditingController();
  var powerController = TextEditingController();
  var priceController = TextEditingController();
  var typeController = TextEditingController();

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
                      'No Chargers found',
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
                  bool isActive = snapshot.data?.docs[index]['active'] ?? false;
                  TextEditingController activeController = TextEditingController(text: isActive.toString());
                  TextEditingController powerController = TextEditingController(text: snapshot.data?.docs[index]['power']);
                  TextEditingController priceController = TextEditingController(text: (snapshot.data?.docs[index]['price'] ?? 0).toString());
                  TextEditingController typeController = TextEditingController(text: snapshot.data?.docs[index]['type']);

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
                                          'Charger Information',
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
                                          'Charger Type:  ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: typeController,
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
                                          'Power Output: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: powerController,
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
                                          'Price for kW/h:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: priceController,
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
                                          'Active Status:  ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: activeController,
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
                                                  updatePrice(snapshot.data!.docs[index].id, int.parse(priceController.text));
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
                                                    'Update Charger',
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

}
