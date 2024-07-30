import 'package:driverapp/drawer.dart';
import 'package:driverapp/driver_provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'ccblock.dart';


class MyCompletedTrips extends StatefulWidget {
  const MyCompletedTrips({super.key});

  @override
  State<MyCompletedTrips> createState() => _MyCompletedTripsState();
}

class _MyCompletedTripsState extends State<MyCompletedTrips> {

  List<Map<String, dynamic>> completedTrips = [];
  late ScrollController _scrollController;
  var driver_id;
  bool _isLoading = true;
  String _errorMessage = '';
  Timer? _refreshTimer;

  Future<void> getCompletedTrips(driver_id) async{
    try{
      var response = await http.post(
        Uri.parse('http://192.168.231.155:5001/getcancelledpostedtrips'),
        headers:  {'Content-Type' : 'application/json'},
        body: jsonEncode(
          {
            "driver_id" : driver_id
          }
        ),
      );

      var data = json.decode(response.body);
      print(data);

      if(data['info'] != null && data['info'].isNotEmpty){
        setState(() {
          completedTrips = List<Map<String,dynamic>>.from(data['info']);
          _isLoading = false;
        });
      }
    }
    catch(e){
      throw e;
    }
  }

 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userProvider = Provider.of<DriverProvider>(context);
    driver_id = userProvider.driver.id;
    getCompletedTrips(driver_id);
    _startRefreshTimer();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startRefreshTimer() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      getCompletedTrips(driver_id);
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DriverAppDrawer(),
      appBar: AppBar(
        title: const Text(
          'Trip History',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[600],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(117, 117, 117, 1),
              ),
            )
          : _errorMessage.isNotEmpty
             ? Center(child: Text(_errorMessage))
              : ListView(
                  controller: _scrollController,
                  children: completedTrips.map((tripInfo) {
                    return CBlock(tripInfo: tripInfo);
                  }).toList(),
                ),
    );
  }
  }
