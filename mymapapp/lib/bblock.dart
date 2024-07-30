import 'package:flutter/material.dart';

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
                  topStart: Radius.circular(15), topEnd: Radius.circular(15)),
              child: Image.network(
                'https://reisenexclusiv.com/wp-content/uploads/2014/08/albert-park_ChameleonsEye_shutterstock.de_.jpg',
                height: 131,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 9.0, left: 9.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${tripInfo['start_location']} - ${tripInfo['end_location']}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('Driver: ${tripInfo['drivername']}',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                            Text('Vehicle: ${tripInfo['name']}',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                    Text('Time: ${tripInfo['time']}',
                        style:
                            const TextStyle(fontSize: 11, fontStyle: FontStyle.italic)),
                    const Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: null,
                      ),
                    )
                  ],
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[700],
              ),
              child: Text( 'Cancel Trip',
                style:  const TextStyle(
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
