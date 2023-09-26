import 'package:ev_admin_terminal/admin/admin_side_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  CollectionReference notesRef = FirebaseFirestore.instance.collection("complaints");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Complaints"),
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
                  // bool isActive = snapshot.data?.docs[index]['active'] ?? false;

                  TextEditingController emailController = TextEditingController(text: snapshot.data?.docs[index]['email']);
                  TextEditingController complaintController = TextEditingController(text: snapshot.data?.docs[index]['complaint']);
                  TextEditingController responseController = TextEditingController();
                  bool status = snapshot.data?.docs[index]['status'];
                  String uid = snapshot.data?.docs[index]['uid'];
                  String? cid = snapshot.data?.docs[index].id;
                  print(status.toString());



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
                                          'Complaints',
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
                                          'User Email:',
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

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Complaint:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: TextFormField(
                                            controller: complaintController,
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
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                // Handle the onTap action here
                                                // This will be executed when the "Open Case" text is clicked
                                                if (status) {
                                                  // Perform the desired action for open case
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: status ? null : Colors.grey,
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                child: status
                                                    ? ElevatedButton(
                                                  onPressed: () {
                                                    // Perform button action here
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) => AlertDialog(
                                                        title: Text('Close Case'),
                                                        content: Text('Do you want to close case?'),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () => Navigator.pop(context),
                                                              child: Text('Cancel')
                                                          ),
                                                          TextButton(
                                                            child: Text('Proceed'),
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                              updateComplaint(snapshot.data?.docs[index].id);
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    primary: Colors.green,
                                                  ),
                                                  child: Text(
                                                    'Open Case',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )
                                                    : Text(
                                                  'Closed Case',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                padding: EdgeInsets.all(8.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (status)
                                        Expanded(
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 45,
                                                width: 300,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    // Perform button action here
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) => AlertDialog(
                                                        title: Text('Send Message'),
                                                        content: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Flexible(
                                                              child: TextField(
                                                                controller: responseController,
                                                                maxLines: null, // Allow the text field to expand vertically
                                                                decoration: InputDecoration(
                                                                  hintText: 'Enter your message...',
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        actions: [
                                                          ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                              primary: Colors.purple,
                                                            ),
                                                            onPressed: () {
                                                              // Send button action
                                                              print("Response Clicked");
                                                              respond(responseController.text, uid, cid!);
                                                              Navigator.of(context).pop();
                                                              showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: Text('Response sent'),
                                                                    content: Text('Response sent to user successfully.'),
                                                                    actions: <Widget>[
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          responseController.clear();
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                        child: Text('OK'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: Text('Send'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    primary: Colors.blue,
                                                  ),
                                                  child: Container(
                                                    child: Text(
                                                      'Respond',
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

  void respond(String message, String uid, String cid) {
    FirebaseFirestore.instance.collection('responses').add({
      'response': message,
      'uid': uid,
      'cid': cid
    })
        .then((value) {
      print('Response added successfully!');
    })
        .catchError((error) {
      print('Failed to add response: $error');
    });
  }

  updateComplaint(docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('complaints')
          .doc(docId)
          .update({'status': false}).then((value) {
            setState(() {

          });});
      print('Status updated successfully');
    } catch (error) {
      print('Error updating status: $error');
    }
  }

}
