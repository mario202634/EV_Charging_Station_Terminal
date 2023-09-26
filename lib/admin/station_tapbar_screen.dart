import 'package:ev_admin_terminal/admin/admin_stations_screen.dart';
import 'package:ev_admin_terminal/admin/view_bookings_screen.dart';
import 'package:ev_admin_terminal/admin/view_chargers_screen.dart';
import 'package:ev_admin_terminal/admin/view_station_screen.dart';
import 'package:flutter/material.dart';

class StationScreen extends StatefulWidget {
  final dynamic stationId;

  const StationScreen({required this.stationId});

  @override
  _StationScreenState createState() => _StationScreenState();
}

class _StationScreenState extends State<StationScreen> {
  late dynamic stationId;

  @override
  void initState() {
    super.initState();
    stationId = widget.stationId;
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
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Stations'),
          centerTitle: true,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     // Handle back button pressed
          //     Navigator.pop(context);
          //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AdminStationScreen()));
          //   },
          // ),
        ),
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
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(text: 'Station'),
                    Tab(text: 'Chargers'),
                    Tab(text: 'Bookings'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(
                      child: ViewStationScreen(stationId: stationId),
                    ),
                    Center(
                      child: ViewChargersScreen(stationId: stationId),
                    ),
                    Center(
                      child: ViewBookingsScreen(stationId: stationId),
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

