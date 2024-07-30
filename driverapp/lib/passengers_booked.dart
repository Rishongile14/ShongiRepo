import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'chat.dart';
import 'drawer.dart';


class BookedPassengers extends StatefulWidget {
  const BookedPassengers( {super.key,required this.driver_id,required this.trip_id});
  final driver_id;
  final trip_id;


  @override
  State<BookedPassengers> createState() => _BookedPassengersState();
}

class _BookedPassengersState extends State<BookedPassengers> {
  List<Map<String, dynamic>> bookedPassengers = [];
  late ScrollController _scrollController;

  Future<void> getPostedTrips() async {
    try {
      var response = await http.post(
        Uri.parse('http://192.168.231.155:5001/getbookedpassengers'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "driver_id": widget.driver_id,
          "trip_id" : widget.trip_id,
        }),
      );

      var data = json.decode(response.body);
      if (data != null) {
        setState(() {
          bookedPassengers = List<Map<String, dynamic>>.from(data['info']);
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPostedTrips();
    //Timer.periodic(Duration(seconds: 2), (Timer t) => getPostedTrips());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DriverAppDrawer(),
      appBar: AppBar(
        title: const Text(
          'Passengers List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[600],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body:  Column(
        children: [
          const Text('Passengers Who Booked',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: bookedPassengers.length,
            itemBuilder: (context, index) {
              var passengerInfo = bookedPassengers[index];
              String passengerNames = passengerInfo['name'] + passengerInfo['lastname'];
              return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 11.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(129, 88, 88, 88),
              offset: Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: _buildPassengerInfo(context, passengerInfo, widget.driver_id, passengerNames)
              ));

            },
          )
        ],
      ),
    );
  }
}

Widget _buildPassengerInfo(BuildContext context, Map<String, dynamic> passengerInfo, int driver_id, String name){
    return Row(
      children: [
        ClipOval(
          child: Image.network(
            'https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg',
            height: 70,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${passengerInfo['name']} ${passengerInfo['lastname']}',
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Passenger',
                style: TextStyle(fontSize: 14.0),
              ),
              
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(CupertinoIcons.person_2_alt, size: 20),
                const SizedBox(width: 3.0),
                Text('${passengerInfo['bookedseats']} Booked Seats', style: const TextStyle(fontSize: 14.0)),
              ],
            ),const SizedBox(height: 5),
            Row(
              children: [
                IconButton(
                        icon: const Icon(Icons.chat_outlined, size: 30),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(passengerName: name, driver_id: driver_id,passenger_id: passengerInfo['passenger_id'],),
                            ),
                          );
                        }
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
