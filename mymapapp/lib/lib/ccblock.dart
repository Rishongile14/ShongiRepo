import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CBlock extends StatelessWidget {
  final Map<String, dynamic> tripInfo;

  const CBlock({super.key, required this.tripInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDriverInfo(),
            const Divider(height: 5, thickness: 1, color: Colors.white10,),
            _buildTripStatus(),
            const Divider(height: 20, thickness: 1),
            _buildTripSection(
              'Outbound Trip Information',
              tripInfo['start_location'],
              tripInfo['end_location'],
              'Daily, ${tripInfo['time']}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverInfo() {
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
                '${tripInfo['drivername']}',
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Driver',
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
                const Icon(CupertinoIcons.car_detailed, size: 20),
                const SizedBox(width: 8.0),
                Text('${tripInfo['name']}', style: const TextStyle(fontSize: 14.0)),
              ],
            ),
            Row(
              children: [
                const Icon(CupertinoIcons.person_2_alt, size: 20),
                const SizedBox(width: 3.0),
                Text('${tripInfo['seats']} Passengers', style: const TextStyle(fontSize: 14.0)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTripSection(String title, String startLocation, String endLocation, String startTime,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8.0),
        _buildLocationRow(startLocation, startTime, Colors.blue),

        _buildDividerLine(),
        _buildLocationRow(endLocation, '', Colors.green),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildLocationRow(String location, String time, Color color) {
    return Row(
      children: [
        ClipOval(
          child: Container(
            height: 40,
            width: 40,
            color: color.withOpacity(0.1),
            child: Icon(Icons.location_on, color: color),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Text(time, style: const TextStyle(fontSize: 14.0)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDividerLine() {
    return Padding(
      padding: const EdgeInsets.only(top: 3,left: 16.0),
      child: Container(
        height: 20.0,
        width: 3.0,
        color: Colors.grey[300],
      ),
    );
  }

 Widget _buildTripStatus() {
  Color statusColor;
  String statusText;

  if (tripInfo['status'] == 'CANCELLED') {
    statusColor = const Color.fromRGBO(183, 28, 28, 1);
    statusText = 'Cancelled';
  } else if (tripInfo['status'] == 'COMPLETED') {
    statusColor = const Color.fromRGBO(27, 94, 32, 1);
    statusText = 'Completed';
  } else {
    statusColor = Colors.black;
    statusText = tripInfo['status'] ?? 'Unknown';
  }
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'Trip Status: $statusText',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  color: statusColor,
                ),
               ),
              const SizedBox(height: 2),
              Text(
                'Date & Time: ${tripInfo['datetime']}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}