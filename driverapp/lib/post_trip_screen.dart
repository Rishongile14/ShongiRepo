import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:provider/provider.dart';

import 'drawer.dart';
import 'driver_provider.dart';

class PostTrip extends StatefulWidget {
  const PostTrip({super.key});

  @override
  State<PostTrip> createState() => _PostTripState();
}

class _PostTripState extends State<PostTrip> {
  LatLng? outboundLocation;
  LatLng? returnLocation;
  String outboundLocationName = 'Select Outbound Location';
  String returnLocationName = 'Select Return Location';
  late Map<String,dynamic> pickedAddress;
  String pickedreturnAddress = 'Search the destination address';
  String pickedoutboundAddress = 'Search the start address';
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final TextEditingController _seatsController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  TimeOfDay? outboundTime;
  TimeOfDay? returnTime;
  String start_latitude = ' ';
  String start_longtude = ' ';
  String destination_latitude = ' ';
  String destination_longtude = ' ';
  var driver_id;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _startController.dispose();
    _endController.dispose();
    _seatsController.dispose();
    _priceController.dispose();
  }

  void Display (){
    Map<String, String> data;
      setState(() {
        data = {
          "start_location": pickedoutboundAddress,
          "end_location": pickedreturnAddress,
          "driver_id": "1",
          "outbound_time": outboundTime!.format(context),
          "return_time": returnTime!.format(context),
          "start_latitude": start_latitude,
          "start_longtude" : start_longtude,
          "destination_latitude" : destination_latitude,
          "destination_longtude" : destination_longtude
        };
      });

  }
  Future<void> postTrips() async {
    try{
      var response = await http.post(Uri.parse('http://192.168.231.155:5001/posttrip'),
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode({
          "start_location": pickedoutboundAddress,
          "end_location": pickedreturnAddress,
          "driver_id": driver_id,
          "outbound_time": outboundTime!.format(context),
          "start_latitude": start_latitude,
          "start_longtude" : start_longtude,
          "destination_latitude" : destination_latitude,
          "destination_longtude" : destination_longtude,
          "seats" : _seatsController.text,
          "price" : _priceController.text
        })
      );

      var data = json.decode(response.body);
      if(data != null && data.isNotEmpty){
        print(data);
        if(data['success'] == true){

          print('You have successfully posted the trip');
        }
      }

    }
    catch(e){
      rethrow;
    }
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
                  print(pickedData);

                  setState(() {
                    if (isOutbound) {
                      outboundLocation = pickedLocation;
                      outboundLocationName =
                      'Latitude: ${pickedLocation!.latitude}, Longitude: ${pickedLocation!.longitude}';
                      start_latitude = '${pickedLocation!.latitude}';
                      start_longtude = '${pickedLocation!.longitude}';
                      pickedoutboundAddress = '${pickedAddress['amenity']} ${pickedAddress['road']} ${pickedAddress['suburb']}';


                    } else {
                      returnLocation = pickedLocation;
                      returnLocationName =
                      'Latitude: ${pickedLocation!.latitude}, Longitude: ${pickedLocation!.longitude}';
                      destination_latitude = '${pickedLocation!.latitude}';
                      destination_longtude = '${pickedLocation!.longitude}';
                      pickedreturnAddress = '${pickedAddress['amenity']} ${pickedAddress['road']} ${pickedAddress['suburb']}';
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

  Future<void> _selectTime(BuildContext context, bool isOutbound) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isOutbound) {
          outboundTime = picked;
        } else {
          returnTime = picked;
        }
      });
    }
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Trip Posted Successful"),
          content: const Text(
              "Your trip has been successfully posted. Thank you for using our platform!",
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/booked');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final driverProvider = Provider.of<DriverProvider>(context);
    driver_id = driverProvider.driver.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DriverAppDrawer(),
      appBar: AppBar(
        title: const Text(
          'Post Trip',
          style: TextStyle(color: Colors.white),
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
                height: 25.0,
              ),
              const Text('Enter Details',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 7.0,
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
                              controller: TextEditingController(text: pickedoutboundAddress),
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(16.0),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                              ),
                                labelText: 'Outbound Address',
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white60,
                              ),
                              maxLines: null,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          IconButton(
                              onPressed:() => _pickLocation(true),
                              icon: const Icon(
                                CupertinoIcons.search,color: Colors.white,
                              )
                          )
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
                              controller: TextEditingController(text: pickedreturnAddress),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(16.0),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                              ),
                                labelText: 'Destination Address',
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white60,
                              ),
                              maxLines: null,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          IconButton(
                              onPressed:() => _pickLocation(false),
                              icon: const Icon(
                                CupertinoIcons.search,color: Colors.white
                              )
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration:  InputDecoration(
                          enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(16.0),

                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                              ),
                                labelText: 'Number of seats available',
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                          ),
                        controller: _seatsController,
                        validator: (value){
                          if(int.parse(value!)  <= 0 && value == null ){
                          }
                          return null;
                        },
                        onChanged: (value){

                        },
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration:  InputDecoration(
                          enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(16.0),

                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                              ),
                                labelText: 'Trip Price per passenger',
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                          ),
                        controller: _priceController,
                        validator: (value){
                          if(int.parse(value!)  <= 0 && value == null ){
                          }
                          return null;
                        },
                        onChanged: (value){

                        },
                      ),
                      const SizedBox(
                          height: 10.0
                      ),
                      Center(
                        child:
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[400]
                            ),
                            onPressed: () => _selectTime(context, true),
                            child: Text(outboundTime == null
                                ? 'Select Outbound Time'
                                : 'Outbound: ${outboundTime!.format(context)}',
                               style: const TextStyle(
                                 color: Colors.white,
                                 fontWeight: FontWeight.bold,
                               ),
                            ),
                          ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[400]
                              ),
                              onPressed: () {
                                postTrips();
                                _showDialog(context);
                              },
                              child: const Text('Post Trip',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ) ,
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
