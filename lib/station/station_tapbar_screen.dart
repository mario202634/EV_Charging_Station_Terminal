import 'package:ev_admin_terminal/admin/admin_add_charger_screen.dart';
import 'package:ev_admin_terminal/admin/admin_stations_screen.dart';
import 'package:ev_admin_terminal/admin/view_bookings_screen.dart';
import 'package:ev_admin_terminal/admin/view_chargers_screen.dart';
import 'package:ev_admin_terminal/admin/view_station_screen.dart';
import 'package:ev_admin_terminal/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          title: Text('Manage Station'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
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
          actions: [
            Row(
              children: [
                Icon(Icons.ev_station_outlined),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddChargerScreen(stationId: widget.stationId,)));
                  },
                )
              ],
            ),
          ],
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
                    color: Colors.purple,
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

