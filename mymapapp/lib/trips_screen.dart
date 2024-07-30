import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Subscription.dart';

class Trips extends StatefulWidget {
  const Trips({super.key, required this.data}); ///required this.data
   final Map<String, String?> data; /// i will get the data from search trip page

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  late List<Map<String, dynamic>> tripDriverInfo = [];
  late ScrollController _scrollController;

  Future<void> getTrips() async {
    try {
      var response = await http.post(
        Uri.parse('http://172.16.12.84:5001/searchtrip'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'start_location': widget.data['start_location'],
          'end_location': widget.data['end_location'],
          'seats': widget.data['seats'],
        }),
      );

      var data = json.decode(response.body);

      print(data);

      if (data['info'] != null && data['info'].isNotEmpty) {
        setState(() {
          tripDriverInfo = List<Map<String, dynamic>>.from(data['info']);
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    getTrips();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        title: Text(
          'Searched Trips',
           textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: tripDriverInfo.length,
        itemBuilder: (context, index) {
          var info = tripDriverInfo[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[600],
              ),
              child: Column(
                children: [
                  // Driver's profile
                  Row(
                    children: [
                      ClipOval(
                        child: Image.network(
                          'https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg',
                          height: 70,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${info['drivername']}', /// drivers name
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Driver',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.car_detailed,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      '${info['name']}',  /// car name
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.person_2_alt,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      '${info['seats']} Passengers',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Outbound Trip Information
                  SizedBox(height: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Outbound Trip Information',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          ClipOval(
                            child: Container(
                              color: Colors.white,
                              height: 40,
                              width: 40,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${info['start_location']}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Daily, 08:00 AM',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 40.0,
                            width: 3.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          ClipOval(
                            child: Container(
                              color: Colors.white,
                              height: 40,
                              width: 40,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${info['end_location']}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Daily, 08:30 AM',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    children: [
                      Center(
                        child: Text(
                          'Return Trip Information',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          ClipOval(
                            child: Container(
                              color: Colors.white,
                              height: 40,
                              width: 40,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${info['end_location']}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Daily, 17:00 PM',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 40.0,
                            width: 3.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          ClipOval(
                            child: Container(
                              color: Colors.white,
                              height: 40,
                              width: 40,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${info['start_location']}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Daily, 17:30 PM',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[700],
                          ),
                          child: Text(
                            'Book Trip',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubscriptionScreen(tripDriverInfo[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
