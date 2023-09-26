import 'package:ev_admin_terminal/admin/admin_add_charger_screen.dart';
import 'package:ev_admin_terminal/admin/admin_stations_screen.dart';
import 'package:ev_admin_terminal/admin/map_sample_screen.dart';
import 'package:ev_admin_terminal/admin/admin_side_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class AdminAddStationScreen extends StatefulWidget {
  dynamic? name;
  dynamic? stationId;
  dynamic? email;
  dynamic? password;
  dynamic? latlng;

  AdminAddStationScreen({this.name, this.stationId, this.email, this.password, this.latlng});

  @override
  _AdminAddStationScreenState createState() => _AdminAddStationScreenState();
}

class _AdminAddStationScreenState extends State<AdminAddStationScreen> {
  dynamic name;
  dynamic stationId;
  dynamic email;
  dynamic password;
  dynamic latlng;

  late TextEditingController nameController;
  late TextEditingController stationIdController;
  late TextEditingController latlngController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  // var cpasswordController = TextEditingController();
  bool _obscureText = true;


//TODO: Create Panel

  final Uuid uuid = const Uuid();
  late String randomNumber;

  void generateRandomNumber() {
    setState(() {
      randomNumber = uuid.v4();
    });
  }

  @override
  void initState() {
    super.initState();
    name = widget.name;
    stationId = widget.stationId;
    email = widget.email;
    password = widget.password;
    nameController = TextEditingController(text: widget.name);
    stationIdController = TextEditingController(text: widget.stationId);
    latlngController = TextEditingController(text: widget.latlng.toString());
    emailController = TextEditingController(text: widget.email);
    passwordController = TextEditingController(text: widget.password);
    print(nameController.text);
    print(stationIdController.text);
    print(latlngController.text);
    print(emailController.text);
    print(passwordController.text);
    generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Stations'),
        centerTitle: true,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     // Handle back button pressed
        //     Navigator.pop(context);
        //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AdminStationScreen()));
        //
        //   },
        // ),
      ),

      // drawer: SideBar(),

      body: Center(
        child: Container(
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (value)
                {
                  print(value);
                },
                decoration: InputDecoration(
                    labelText: 'Station Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.account_circle_outlined,
                    )
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: latlngController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Pick Location',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.location_on,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.navigate_next),
                    onPressed: () {
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MapSample(nameController.text, randomNumber, emailController.text, passwordController.text,)),);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MapSample(name: nameController.text, stationId: randomNumber, email: emailController.text, password: passwordController.text,)),);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value)
                {
                  print(value);
                },
                decoration: InputDecoration(
                    labelText: 'E-Mail Address',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                    )
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  suffixIcon: IconButton(
                    icon: _obscureText
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Station ID:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                randomNumber,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20,),
              Container(
                color: Colors.purple,
                // width: double.infinity,
                height: 45,
                width: 500,
                child: MaterialButton(
                  onPressed: ()
                  {
                    print(emailController.text);
                    print(passwordController.text);
                    signUp(nameController.text, emailController.text);
                    deleteSuggestedStation();
                    setState(() {
                      nameController.clear();
                      stationIdController.clear();
                      latlngController.clear();
                      emailController.clear();
                      passwordController.clear();
                    });
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Added'),
                        content: Text('Station Added Successfully'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK')
                          ),
                        ],
                      ),
                    );
                    // MaterialPageRoute(builder: (context) => MapScreen());
                  },
                  child: Container(
                    child: Text(
                      'Save Station',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: generateRandomNumber,
      //   tooltip: 'Generate',
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }


  void signUp(name, email) {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text!,
      password: passwordController.text!,
    )
        .then((value) {
      addUserData(value.user!.uid, name, email);
      addStationOwner(value.user!.uid);
    }).catchError((error) {

    });
  }

  // Future addStation(random) async {
  //   final stationData = {
  //     'name': nameController.text.trim(),
  //     'stationId': stationIdController.text.trim(),
  //     'location': GeoPoint(widget.latlng.latitude, widget.latlng.longitude)
  //     // 'location': GeoPoint(
  //     //   double.parse(latController.text.trim()),
  //     //   double.parse(lngController.text.trim()),
  //     // ),
  //   };
  //   print("Variable StationData" + stationData.toString());
  //   await FirebaseFirestore.instance.collection('stations').add(stationData);
  // }



Future addUserData(uid, name, email) async {
  await FirebaseFirestore.instance.collection('stations').doc(uid).set({
'name': name,
'stationId': randomNumber,
'location': GeoPoint(widget.latlng.latitude, widget.latlng.longitude),
'email': email,

  });
}

  Future addStationOwner(uid) async {
    await FirebaseFirestore.instance.collection('stationOwner').doc(uid).set({
      'stationId': randomNumber,
      'email': emailController.text.trim(),
    });
  }

  Future<void> deleteSuggestedStation() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('suggestedStations')
          .where('name', isEqualTo: nameController.text)
          .get();

      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
      print('Station deleted successfully');

    } catch (error) {
      print('Error deleting documents: $error');
    }
  }

}
