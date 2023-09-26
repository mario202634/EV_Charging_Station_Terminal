import 'package:ev_admin_terminal/admin/admin_chargers_screen.dart';
import 'package:ev_admin_terminal/admin/admin_combined_stations.dart';
import 'package:ev_admin_terminal/admin/admin_home_screen.dart';
import 'package:ev_admin_terminal/admin/admin_stations_screen.dart';
import 'package:ev_admin_terminal/admin/admin_bookings_screen.dart';
import 'package:ev_admin_terminal/admin/admin_complaints_screen.dart';
import 'package:ev_admin_terminal/admin/admin_users_screen.dart';
import 'package:ev_admin_terminal/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String getEmail() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return user.email ?? '';
  }
  return '';
}

class AdminSideBar extends StatefulWidget {
  @override
  State<AdminSideBar> createState() => _AdminSideBarState();
}

class _AdminSideBarState extends State<AdminSideBar> {


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Home'),
            // onTap: () {
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()),
            //   );
            // },
            onTap: (){
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AdminHomeScreen()));
            },
          ),

          Divider(),


          ListTile(
            leading: Icon(Icons.ev_station),
            title: Text('Stations'),
            // onTap: () {
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()),
            //   );
            // },
            onTap: (){
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CombinedStations()));
            },
          ),
          ListTile(
            leading: Icon(Icons.bolt),
            title: Text('Chargers'),
            onTap: (){
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminChargerScreen()));
            },
          ),

          ListTile(
            leading: Icon(Icons.library_books_outlined),
            title: Text('Bookings'),
            onTap: (){
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminBookingScreen()));
            },
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.admin_panel_settings_outlined),
            title: Text('Admins'),
            onTap: (){
              Navigator.pop(context);
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactUsScreen()));
            },
          ),

          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text('Users'),
            onTap: (){
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminUsersScreen()));
            },
          ),

          ListTile(
            leading: Icon(Icons.message_outlined),
            title: Text('Complaints'),
            onTap: (){
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ComplaintsScreen()));
            },
          ),

          Divider(),

          ListTile(
            title: Text('Log Out'),
            leading: Icon(Icons.exit_to_app),
            onTap: (){
              //Navigator.pop(context);
              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Logout'),
                  content: Text('Are you sure you want to log out?'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel')
                    ),
                    TextButton(
                      child: Text('Logout'),
                      onPressed: () {
                        Navigator.pop(context);
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}