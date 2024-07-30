import 'package:flutter/material.dart';
import 'bblock.dart';

class HistoryDesign extends StatefulWidget {
  final List<Map<String, dynamic>> tripList;
  final Function(int) onCancelTrip;

  const HistoryDesign({super.key, required this.tripList, required this.onCancelTrip});

  @override
  _HistoryDesignState createState() => _HistoryDesignState();
}

class _HistoryDesignState extends State<HistoryDesign> {
  void _confirmCancelTrip(int bookedTripsId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Trip'),
          content: const Text('Are you sure you want to cancel this trip?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (widget.onCancelTrip != null) {
                  widget.onCancelTrip!(bookedTripsId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Trip cancelled successfully')),
                  );
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.tripList.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline, color: Color.fromRGBO(117, 117, 117, 1), size: 50),
                  SizedBox(height: 10),
                  Text(
                    'No trips available!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Color.fromRGBO(117, 117, 117, 1)),
                  ),
                ],
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: widget.tripList.length,
              itemBuilder: (context, index) {
                var tripInfo = widget.tripList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 11.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 2),
                          Block(
                              tripInfo: tripInfo,
                              onCancel: () {
                                _confirmCancelTrip(tripInfo['bookedtrips_id']);
                              },
                            ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
