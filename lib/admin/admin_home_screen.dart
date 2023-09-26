import 'package:ev_admin_terminal/admin/HoverCard.dart';
import 'package:ev_admin_terminal/admin/admin_admins_screen.dart';
import 'package:ev_admin_terminal/admin/admin_bookings_screen.dart';
import 'package:ev_admin_terminal/admin/admin_chargers_screen.dart';
import 'package:ev_admin_terminal/admin/admin_combined_stations.dart';
import 'package:ev_admin_terminal/admin/admin_complaints_screen.dart';
import 'package:ev_admin_terminal/admin/admin_stations_screen.dart';
import 'package:ev_admin_terminal/admin/admin_side_bar.dart';
import 'package:ev_admin_terminal/admin/admin_users_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Admin'
        ),
        centerTitle: true,
      ),
      drawer: AdminSideBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(100.0,0,100,0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              'Welcome Mario!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Manage Stations & Chargers',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              height: 20,
              thickness: 2,
            ),
            // Expanded(
            //   child: GridView.count(
            //     crossAxisCount: 3, // Number of containers in each row
            //     crossAxisSpacing: 50, // Spacing between containers horizontally
            //     mainAxisSpacing: 10, // Spacing between containers vertically
            //     children: [
            //       // Add more Column widgets for the remaining containers
            //       // Repeat the structure for each container
            //       Container(
            //           width: 200,
            //           child: HoverCard('Stations', Icons.ev_station, AdminStationScreen(),)
            //       ),
            //       HoverCard('Chargers', Icons.bolt, AdminChargerScreen(),),
            //       HoverCard('Bookings', Icons.library_books_outlined, AdminBookingScreen(),),
            //     ],
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    width: 250,
                    height: 250,
                    child: HoverCard('Stations', Icons.ev_station, CombinedStations(),)
                ),
                SizedBox(width: 80,),
                Container(
                    width: 250,
                    height: 250,
                    child: HoverCard('Chargers', Icons.bolt, AdminChargerScreen(),)),
                SizedBox(width: 80,),
                Container(
                    width: 250,
                    height: 250,
                    child: HoverCard('Bookings', Icons.library_books_outlined, AdminBookingScreen(),)),

              ],
            ),
            SizedBox(height: 50),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Manage People',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              // endIndent: 150,
              // indent: 150,
              height: 20,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 250,
                      height: 250,
                      child: HoverCard('Admins', Icons.admin_panel_settings_outlined, AdminAdminsScreen(),)),
                  SizedBox(width: 80,),
                  Container(
                      width: 250,
                      height: 250,
                      child: HoverCard('Users', Icons.account_circle_outlined, AdminUsersScreen(),)),
                  SizedBox(width: 80,),
                  Container(
                      width: 250,
                      height: 250,
                      child: HoverCard('Complaints', Icons.message_outlined, ComplaintsScreen(),)),
                ],
            ),
          ],
        ),
      ),

    );
  }
}
