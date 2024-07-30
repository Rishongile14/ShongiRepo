import 'package:flutter/material.dart';
import 'drawer.dart';
import 'package:provider/provider.dart';
import 'package:driverapp/driver_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                final userProvider =
                    Provider.of<DriverProvider>(context, listen: false);
                userProvider.clearUser();

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully')),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DriverAppDrawer(),
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[600],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'TripTogether',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/image2.jpg',
                fit: BoxFit.cover,
                height: 300,
                width: 600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'What would you like to do?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/booked');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade600,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      child: const Text(
                        'View My Trips',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/post');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade600,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      child: const Text(
                        'Post Trips',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/history');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade600,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      child: const Text(
                        'My Trip History',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        _confirmLogout(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade600,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
