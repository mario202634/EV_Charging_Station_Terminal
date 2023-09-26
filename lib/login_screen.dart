import 'package:ev_admin_terminal/admin/admin_home_screen.dart';
import 'package:ev_admin_terminal/admin/admin_stations_screen.dart';
import 'package:ev_admin_terminal/reset_password_screen.dart';
import 'package:ev_admin_terminal/station/station_tapbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';
class LoginScreen extends StatefulWidget
{
  const LoginScreen({Key?key}) : super(key:key); //to know why

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _obscureText = true;
  bool isAdminSelected = true;
  bool isStationSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/images/login2.png'),
                width: 250, // Set the desired width
                height: 250, // Set the desired height
              ),
              Text("Welcome to Charging Pal Web Application",
                style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 20.0),
              Container(
                width: 500,
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'E-Mail Address',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                width: 500,
                child: TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
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
              ),
              SizedBox(height: 5.0),
              Container(
                width: 500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isAdminSelected = true;
                              isStationSelected = false;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                                if (isAdminSelected && !isStationSelected) {
                                  return Colors.purple; // Selected button color
                                }
                                return Colors.white; // Default button color
                              },
                            ),
                          ),
                          child: Text(
                            'Admin',
                            style: TextStyle(
                              color: isAdminSelected ? Colors.white : Colors.black, // Selected button text color
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isAdminSelected = false;
                              isStationSelected = true;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                                if (!isAdminSelected && isStationSelected) {
                                  return Colors.purple; // Selected button color
                                }
                                return Colors.white; // Default button color
                              },
                            ),
                          ),
                          child: Text(
                            'Station',
                            style: TextStyle(
                              color: isStationSelected ? Colors.white : Colors.black, // Selected button text color
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Reset Password',
                        style: TextStyle(),
                      ),
                    ),
                  ],
                ),

              ),
              SizedBox(height: 20),
              Container(
                height: 45,
                width: 500,
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    ).then((value) {
                      if(isAdminSelected == true) {
                        bgrbadmin();
                        // Handle admin login logic
                      }
                      if(isStationSelected == true){
                        FirebaseFirestore.instance
                            .collection('stations')
                            .where('email', isEqualTo: emailController.text)
                            .get().then((value) {
                          print("Station Logged");
                          print("Station email: " + emailController.text);
                          retrieveStationIdAndNavigate();
                        });
                      }
                    }).catchError((onError) {
                      print('Error: $onError');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Center(
                                child: Text("SORRY, WRONG LOGIN CREDENTIALS")
                            ),
                            content: Text("Please check your email and password and try again."),
                            actions: <Widget>[
                              Center(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    });

                    print(emailController.text);
                    print(passwordController.text);
                    if(isAdminSelected == false && isStationSelected == false) {
                      print("Select Type");
                    }
                    print(isAdminSelected.toString());
                    print(isStationSelected.toString());
                  },
                  style: ElevatedButton.styleFrom(
                    primary: HexColor("#131734"), // Set the button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Set the border radius
                    ),
                  ),
                  child: Container(
                    child: Text(
                      'LOGIN',
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
    );
  }

  isStationCheck() async {
    try {
      await FirebaseFirestore.instance
          .collection('stations')
          .where('email', isEqualTo: emailController.toString())
          .limit(1)
          .get().then((value)
      {
        StationlogIn();
      });

    }
    catch (error) {
      print('Error checking charger type existence: $error');
    }
  }

  isAdminCheck() async {
    try {
      await FirebaseFirestore.instance
          .collection('admins')
          .where('email', isEqualTo: emailController.text)
          .limit(1)
          .get().then((value) {
        AdminlogIn();
      });

    }
    catch (error) {
      print('Error checking charger type existence: $error');
    }
  }


  Future StationlogIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()).then((value) {
      FirebaseFirestore.instance.collection('stations')
          .where('email', isEqualTo: emailController.text)
          .get().then((value) {
        print('logged in successfully');
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AdminHomeScreen()),
        );
      }).onError((error, stackTrace) {
        print('can not find super admin in firestore');
      });
    }).onError((error, stackTrace) {
      print('can not find user');
    });

    //Navigator.push(context, MaterialPageRoute(builder: (context) => MapTestScreen()),);
  }

  Future AdminlogIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()).then((value) {
      FirebaseFirestore.instance.collection('admins')
          .where('email', isEqualTo: emailController.text)
          .get().then((value) {
        print('logged in successfully');
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AdminHomeScreen()),
        );
      }).onError((error, stackTrace) {
        print('can not find super admin in firestore');
      });
    }).onError((error, stackTrace) {
      print('can not find user');
    });
    //Navigator.push(context, MaterialPageRoute(builder: (context) => MapTestScreen()),);
  }

  void retrieveStationIdAndNavigate() async {
    try {
      // Retrieve the stationId from the "stations" collection
      QuerySnapshot stationSnapshot = await FirebaseFirestore.instance
          .collection('stations')
          .where('email', isEqualTo: emailController.text)
          .get();

      if (stationSnapshot.docs.isNotEmpty) {
        DocumentSnapshot firstDocument = stationSnapshot.docs.first;
        String stationId = firstDocument.get('stationId');

        // Navigate to the desired screen and pass the stationId as an argument
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StationScreen(stationId: stationId),
          ),
        );
      } else {
        print('Station not found');
      }
    } catch (error) {
      print('Failed to retrieve stationId: $error');
    }
  }

  void bgrbadmin() async {
    try {
      // Retrieve the stationId from the "stations" collection
      QuerySnapshot stationSnapshot = await FirebaseFirestore.instance
          .collection('admins')
          .where('email', isEqualTo: emailController.text)
          .get();

      if (stationSnapshot.docs.isNotEmpty) {

        FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdminHomeScreen(),
          ),
        );
      } else {
        print('Station not found');
      }
    } catch (error) {
      print('Failed to retrieve stationId: $error');
    }
  }


  @override //for better memory efficiency
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

}
