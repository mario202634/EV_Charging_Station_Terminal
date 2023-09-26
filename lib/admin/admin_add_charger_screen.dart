import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_admin_terminal/admin/admin_combined_stations.dart';
import 'package:flutter/material.dart';

class AddChargerScreen extends StatefulWidget {
  final dynamic stationId;

  const AddChargerScreen({this.stationId});

  @override
  _AddChargerScreenState createState() => _AddChargerScreenState(stationId);
}

class _AddChargerScreenState extends State<AddChargerScreen> {
  final dynamic stationId;
  _AddChargerScreenState(this.stationId);

  late TextEditingController nameController;
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: stationId.toString());
  }

  final List<String> actype1 = [
    '3.7 kW/h',
    '7 kW/h',
  ];

  final List<String> actype2 = [
    '3.7 kW/h',
    '7 kW/h',
    '22 kW/h',
  ];

  final List<String> dcCHAdeMO = [
    '50 kW/h',
    '100 kW/h',
  ];

  final List<String> dcccs = [
    '50 kW/h',
    '150 kW/h',
    '350 kW/h',
  ];

  final List<String> dctype2 = [
    '150 kW/h',
    '250 kW/h',
  ];

  final List<String> threepin = [
    '2.7 kW/h',
  ];

  String? selectedCardModel;
  String? selectedMake;

  late Map<String, List<String>> dataset = {
    'AC Type 1': actype1,
    'AC Type 2': actype2,
    'DC CHAdeMO ': dcCHAdeMO,
    'DC CCS ': dcccs,
    'DC Type 2  ': dctype2,
    '3-Pin Plug ': threepin,

  };

  onCarModelChanged(String? value) {
    //dont change second dropdown if 1st item didnt change
    if (value != selectedCardModel) selectedMake = null;
    setState(() {
      selectedCardModel = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Add Charger'
        ),
        centerTitle: true,
      ),      // body: Column(
      //   children: [
      //     DropdownButton<String?>(
      //         value: selectedCardModel,
      //         items: dataset.keys.map((e) {
      //           return DropdownMenuItem<String?>(
      //             value: e,
      //             child: Text('$e'),
      //           );
      //         }).toList(),
      //         onChanged: onCarModelChanged),
      //     const SizedBox(
      //       height: 10,
      //     ),
      //     DropdownButton<String?>(
      //         value: selectedMake,
      //         items: (dataset[selectedCardModel] ?? []).map((e) {
      //           return DropdownMenuItem<String?>(
      //             value: e,
      //             child: Text('$e'),
      //           );
      //         }).toList(),
      //         onChanged: (val) {
      //           setState(() {
      //             selectedMake = val!;
      //           });
      //         }),
      //     //
      //   ],
      // ),
      body: Center(
        child: Container(
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TextFormField(
              //   controller: nameController,
              //   enabled: false,
              //   keyboardType: TextInputType.text,
              //   onFieldSubmitted: (value)
              //   {
              //     print(value);
              //   },
              //   decoration: InputDecoration(
              //       labelText: 'Station Id:',
              //       border: OutlineInputBorder(),
              //       prefixIcon: Icon(
              //         Icons.account_circle_outlined,
              //       )
              //   ),
              // ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButton<String>(
                  hint: Text("Select Charger Type"),
                  value: selectedCardModel,
                  items: dataset.keys.map((e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: Text('$e'),
                    );
                  }).toList(),
                  onChanged: onCarModelChanged,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  underline: Container(), // Remove the underline
                  isExpanded: true,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButton<String?>(
                  hint: Text("Select Charger Power Output"),
                  value: selectedMake,
                  items: (dataset[selectedCardModel] ?? []).map((e) {
                    return DropdownMenuItem<String?>(
                      value: e,
                      child: Text('$e'),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedMake = val!;
                      print("Selected Type: $selectedCardModel");
                      print("Selected Power: $selectedMake");
                    });
                  },
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  underline: SizedBox(),
                  isExpanded: true,
                ),
              ),
              SizedBox(height: 20,),

              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (value)
                {
                  print(value);
                },
                decoration: InputDecoration(
                    labelText: 'Price for kW/h:',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.account_circle_outlined,
                    )
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Container(
                color: Colors.purple,
                // width: double.infinity,
                height: 45,
                width: 500,
                child: MaterialButton(
                  onPressed: ()
                  {
                    addUserData();
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CombinedStations()));
                    setState(() {
                      nameController.clear();
                      priceController.clear();
                    });
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Added'),
                        content: Text('Chargers Added Successfully'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK')
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    child: Text(
                      'Save Charger',
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
  Future addUserData() async {
    await FirebaseFirestore.instance.collection('chargers').doc().set({
      'active': false,
      'power': selectedMake,
      'price': int.parse(priceController.text.trim()),
      'stationId': stationId,
      'type': selectedCardModel,
    });
    print(selectedMake);
    print(priceController.text);
    print(stationId);
    print(selectedCardModel);
  }
}
