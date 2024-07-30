import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:mymapapp/provider.dart';
import 'ccblock.dart';
import 'drawer.dart';

class CancelledCompletedTrips extends StatefulWidget {
  const CancelledCompletedTrips({super.key});

  @override
  State<CancelledCompletedTrips> createState() => _CancelledCompletedTripsState();
}

class _CancelledCompletedTripsState extends State<CancelledCompletedTrips> {
  var id;
  late List<Map<String, dynamic>> cancelledCompletedTrips = [];
  late ScrollController _scrollController;
  bool _isLoading = true;
  String _errorMessage = '';
  Timer? _refreshTimer;

  Future<void> getCompletedTrips(passengerId) async {
    try {
      var response = await http.post(
        Uri.parse('http://172.16.12.84:5001/getcompletedtrips'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'passenger_id': passengerId}),
      );

      var data = json.decode(response.body);
      if (data['info'] != null && data['info'].isNotEmpty) {
        setState(() {
          cancelledCompletedTrips = List<Map<String, dynamic>>.from(data['info']);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'No trips available!';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load trips';
      });
    }
  }

 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userProvider = Provider.of<UserProvider>(context);
    id = userProvider.user.id;
    getCompletedTrips(id);
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
      getCompletedTrips(id);
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
      drawer: const PassengerAppDrawer(),
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
                  children: cancelledCompletedTrips.map((tripInfo) {
                    return CBlock(tripInfo: tripInfo);
                  }).toList(),
                ),
    );
  }
}
