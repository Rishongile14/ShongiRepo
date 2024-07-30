import 'dart:async';
import 'dart:convert';
import 'package:driverapp/driver_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'booked_trips_design.dart';
import 'drawer.dart';

class MyTrips extends StatefulWidget {
  const MyTrips({super.key});

  @override
  State<MyTrips> createState() => _MyTripsState();
}

class _MyTripsState extends State<MyTrips> {
  List<Map<String, dynamic>> postedtrips = [];
  late ScrollController _scrollController;
  late Timer _timer;
  var driver_id;
  final DateTime currentdatetime = DateTime.now();

  Future<void> cancelTrip(int driverId, int tripId) async {
    try {
      var response = await http.post(
        Uri.parse('http://192.168.231.155:5001/cancelpostedtrip'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "driver_id": driverId,
          "trip_id": tripId,
        }),
      );

      if (response.statusCode == 200) {
        // Successfully cancelled the trip
        if (mounted) {
          setState(() {
            postedtrips.removeWhere((trip) => trip['trip_id'] == tripId);
          });
        }
      } else {
        throw Exception('Failed to cancel trip');
      }
    } catch (e) {
      print('Error cancelling trip: $e');
    }
  }

  Future<void> getPostedTrips(int driverId) async {
    try {
      var response = await http.post(
        Uri.parse('http://192.168.231.155:5001/getpostedtrips'),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "driver_id": driverId
        }),
      );

      var data = json.decode(response.body);
      if (data != null) {
        if (mounted) {
          setState(() {
            postedtrips = List<Map<String, dynamic>>.from(data['info']);
          });
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final driverProvider = Provider.of<DriverProvider>(context);
    driver_id = driverProvider.driver.id;
    getPostedTrips(driver_id);
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer t) => getPostedTrips(driver_id));
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DriverAppDrawer(),
      appBar: AppBar(
        title: const Text(
          'My Trips',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[600],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: HistoryDesign(
              tripList: postedtrips,
              onCancelTrip: (tripId) => cancelTrip(driver_id, tripId),
            ),
          ),
        ],
      ),
    );
  }
}
