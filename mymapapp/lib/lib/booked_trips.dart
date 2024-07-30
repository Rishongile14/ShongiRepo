import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'booked_trips_design.dart';
import 'package:http/http.dart' as http;
import 'package:mymapapp/provider.dart';
import 'package:provider/provider.dart';

import 'drawer.dart';


class BookedTrips extends StatefulWidget {
  const BookedTrips({super.key});

@override
  State<BookedTrips> createState() => _BookedTripsState();
}

class _BookedTripsState extends State<BookedTrips> {
  late List<Map<String, dynamic>> bookedtripinfo = [];
  late ScrollController _scrollController;
  final DateTime currentdatetime = DateTime.now();
  late int id;

  Future<bool> deleteCompletedTrip(int passengerId, int bookedTripsId) async {
    try {
      var response = await http.post(
        Uri.parse('http://192.168.231.155:5001/deletebookedtrip'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'passenger_id': passengerId,
          'bookedtrips_id': bookedTripsId,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data != null && data['success'] == true;
      } else {
        print('Server error: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error in deleteCompletedTrip: $e');
      return false;
    }
  }


  Future<void> tripCompleted(int bookedTripsId) async {
    print('passenger id current $id');
    try {
      var response = await http.post(
        Uri.parse('http://192.168.231.155:5001/addcompletedtrip'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'bookedtrips_id': bookedTripsId,
          'datetime': currentdatetime.toString(),
          'status': 'CANCELLED',
          "passenger_id" : id,
        })
      );

       var data = json.decode(response.body);
      if (data != null) {
        bool deleted = await deleteCompletedTrip(id, bookedTripsId);
        if (deleted) {
          setState(() {
            bookedtripinfo.removeWhere((trip) => trip['bookedtrips_id'] == bookedTripsId);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Trip cancelled successfully.'),
              duration: Duration(seconds: 2),
            ),
            );
        }
      }
    } catch (e) {
      print('Error in tripCompleted: $e');
    }
  }

  Future<void> getBookedTrips(int id) async {
    try {
      var response = await http.post(
        Uri.parse('http://192.168.231.155:5001/getbooktrips'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'passenger_id': id,
        }),
      );

      var data = json.decode(response.body);

      if (data['info'] != null && data['info'].isNotEmpty) {
        setState(() {
          bookedtripinfo = List<Map<String, dynamic>>.from(data['info']);
        });
      }
    } catch (e) {
      print('Error in getBookedTrips: $e');
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
    final userProvider = Provider.of<UserProvider>(context);
    id = userProvider.user.id;
    getBookedTrips(id);
    Timer.periodic(const Duration(seconds: 2), (Timer t) => getBookedTrips(id));
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const PassengerAppDrawer(),
      appBar: AppBar(
        title: const Text("Booked Trips",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey[600],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: HistoryDesign(
              tripList: bookedtripinfo,
              onCancelTrip: (tripId) => tripCompleted(tripId),
            ),
          ),
        ],
      ),
    );
  }

}


