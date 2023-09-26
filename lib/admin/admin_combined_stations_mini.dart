import 'package:ev_admin_terminal/admin/admin_add_station_screen.dart';
import 'package:ev_admin_terminal/admin/admin_map_stations_screen.dart';
import 'package:ev_admin_terminal/admin/admin_side_bar.dart';
import 'package:ev_admin_terminal/admin/admin_stations_screen.dart';
import 'package:ev_admin_terminal/admin/map_sample_screen.dart';
import 'package:ev_admin_terminal/admin/view_bookings_screen.dart';
import 'package:ev_admin_terminal/admin/view_chargers_screen.dart';
import 'package:ev_admin_terminal/admin/view_station_screen.dart';
import 'package:ev_admin_terminal/test_screen.dart';
import 'package:flutter/material.dart';

class CombinedStationsMini extends StatefulWidget {

  const CombinedStationsMini();

  @override
  _CombinedStationsMiniState createState() => _CombinedStationsMiniState();
}

class _CombinedStationsMiniState extends State<CombinedStationsMini> {

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
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                height: 30, // Adjust the height as needed
                width: 200,
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
                    Tab(text: 'List View'),
                    Tab(text: 'Map View'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(
                      child: AdminStationScreen(),
                    ),
                    Center(
                      child: TestingScreen(),
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

