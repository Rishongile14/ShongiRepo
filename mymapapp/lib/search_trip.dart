import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:latlong2/latlong.dart';
import 'drawer.dart';
import 'trips_screen.dart';

class SelectTravelDaysScreen extends StatefulWidget {
  const SelectTravelDaysScreen({super.key});

  @override
  _SelectTravelDaysScreenState createState() => _SelectTravelDaysScreenState();
}

class _SelectTravelDaysScreenState extends State<SelectTravelDaysScreen> {
  LatLng? outboundLocation;
  LatLng? returnLocation;
  String outboundLocationName = 'Select Outbound Location';
  String returnLocationName = 'Select Return Location';
  late Map<String, dynamic> pickedAddress;
  String pickedreturnAddress = 'Search the destination address';
  String pickedoutboundAddress = 'Search the start address';
  String start_latitude = ' ';
  String start_longtude = ' ';
  String destination_latitude = ' ';
  String destination_longtude = ' ';

  Map<String, String?> data = {
    'start_location': null,
    'end_location': null,
    'seats': null,
    'start_latitude': null,
    'start_longtude': null,
    'destination_latitude': null,
    'destination_longtude': null,
  };

  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final TextEditingController _seatsController = TextEditingController();

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    _seatsController.dispose();
    super.dispose();
  }

  Future<void> _pickLocation(bool isOutbound) async {
    LatLng? pickedLocation;
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: [
            Expanded(
              child: OpenStreetMapSearchAndPick(
                locationPinTextStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                locationPinIconColor: Colors.grey.shade600,
                buttonColor: Colors.grey.shade600,
                buttonText: 'Set Current Location',
                onPicked: (pickedData) {
                  pickedAddress = pickedData.address;
                  pickedLocation = LatLng(
                    pickedData.latLong.latitude,
                    pickedData.latLong.longitude,
                  );

                  setState(() {
                    if (isOutbound) {
                      outboundLocation = pickedLocation;
                      outboundLocationName =
                          'Latitude: ${pickedLocation!.latitude}, Longitude: ${pickedLocation!.longitude}';
                      start_latitude = '${pickedLocation!.latitude}';
                      start_longtude = '${pickedLocation!.longitude}';
                      pickedoutboundAddress =
                          '${pickedAddress['amenity']} ${pickedAddress['road']} ${pickedAddress['suburb']}';
                    } else {
                      returnLocation = pickedLocation;
                      returnLocationName =
                          'Latitude: ${pickedLocation!.latitude}, Longitude: ${pickedLocation!.longitude}';
                      destination_latitude = '${pickedLocation!.latitude}';
                      destination_longtude = '${pickedLocation!.longitude}';
                      pickedreturnAddress =
                          '${pickedAddress['amenity']} ${pickedAddress['road']} ${pickedAddress['suburb']}';
                    }
                  });

                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  var current_user; /// to keep track of current user
  var trip_selcetd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const PassengerAppDrawer(),
      appBar: AppBar(
        title: const Text("Search Trip",
          style:  TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey[600],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: const Image(
                  image: AssetImage('assets/image1.jpg'),
                  fit: BoxFit.cover,
                  height: 300,
                  width: 500,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              const Text(
                'Enter Details',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: TextEditingController(
                                  text: pickedoutboundAddress),
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Outbound Address',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                              maxLines: null,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          IconButton(
                            onPressed: () => _pickLocation(true),
                            icon: const Icon(
                              CupertinoIcons.search,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              controller: TextEditingController(
                                  text: pickedreturnAddress),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Destination Address',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                              maxLines: null,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          IconButton(
                            onPressed: () => _pickLocation(false),
                            icon: const Icon(
                              CupertinoIcons.search,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter number of passengers',
                          hintStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        controller: _seatsController,
                        validator: (value) {
                          if (int.parse(value!) <= 0 && value == null) {}
                        },
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[400],
                              ),
                              onPressed: () {
                                setState(() {
                                  data['start_location'] =
                                      pickedoutboundAddress;
                                  data['end_location'] = pickedreturnAddress;
                                  data['seats'] = _seatsController.text;
                                  data['start_latitude'] = start_latitude;
                                  data['start_longtude'] = start_longtude;
                                  data['destination_latitude'] =
                                      destination_latitude;
                                  data['destination_longtude'] =
                                      destination_longtude;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Trips(data: data),
                                  ),
                                );
                              },
                              child: const Text(
                                'Search Trips',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
