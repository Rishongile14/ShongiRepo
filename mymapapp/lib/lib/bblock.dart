import 'package:flutter/material.dart';
import 'package:mymapapp/chat.dart';
import 'package:mymapapp/trip_despcription_screen.dart';

class Block extends StatelessWidget {
  final Map<String, dynamic> tripInfo;
  final VoidCallback onCancel;

  const Block({super.key, required this.tripInfo, required this.onCancel});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 22.0),
      child: Container(
        height: 300,
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
            BoxShadow(
              color: Color.fromARGB(0, 233, 233, 233),
              offset: Offset(0, -6),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(15),
                topEnd: Radius.circular(15),
              ),
              child: Image.network(
                'https://reisenexclusiv.com/wp-content/uploads/2014/08/albert-park_ChameleonsEye_shutterstock.de_.jpg',
                height: 131,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 9.0, left: 9.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${tripInfo['start_location']} - ${tripInfo['end_location']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Driver: ${tripInfo['drivername']}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Vehicle: ${tripInfo['name']}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Time: ${tripInfo['time']}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        IconButton(
                        icon: const Icon(Icons.chat_outlined, size: 30),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(driverName: tripInfo['drivername'],driver_id: tripInfo['driver_id'],passenger_id: tripInfo['passenger_id'],),
                            ),
                          );
                        },
                      ),const SizedBox(width: 5,),
                        IconButton(
                        icon: const Icon(Icons.arrow_forward, size: 30),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DescriptionPage(trip: tripInfo,onCancel: onCancel,),
                            ),
                          );
                        },
                      ),
                      ]
                      )
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[600],
              ),
              child: const Text(
                'Cancel Trip',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: onCancel,
            ),
          ],
        ),
      ),
    );
  }
}
