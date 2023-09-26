import 'package:ev_admin_terminal/admin/admin_add_station_screen.dart';
import 'package:ev_admin_terminal/admin/admin_combined_stations_mini.dart';
import 'package:ev_admin_terminal/admin/admin_side_bar.dart';
import 'package:ev_admin_terminal/admin/admin_stations_screen.dart';
import 'package:ev_admin_terminal/admin/admin_suggested_stations_screen.dart';
import 'package:ev_admin_terminal/admin/map_sample_screen.dart';
import 'package:ev_admin_terminal/admin/view_bookings_screen.dart';
import 'package:ev_admin_terminal/admin/view_chargers_screen.dart';
import 'package:ev_admin_terminal/admin/view_station_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
class CombinedStations extends StatefulWidget {

  const CombinedStations();

  @override
  _CombinedStationsState createState() => _CombinedStationsState();
}

class _CombinedStationsState extends State<CombinedStations> {

  @override
  void initState() {
    super.initState();
  }

  int _selectedButtonIndex = 0;

  void _onButtonPressed(int buttonIndex) {
    setState(() {
      _selectedButtonIndex = buttonIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Stations"),
          centerTitle: true,
          actions: [
            Row(
              children: [
                Text(
                  'Add Station',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Handle button press here
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminAddStationScreen()));
                  },
                ),

              ],
            )

          ],
        ),

        drawer: AdminSideBar(),

        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 45,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(text: 'Station'),
                    Tab(text: 'User Suggested'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(
                      //child: AdminStationScreen(),
                      child: CombinedStationsMini(),
                    ),
                    Center(
                      child: AdminSuggestedStationScreen(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

