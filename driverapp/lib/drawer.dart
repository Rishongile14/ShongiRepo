import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driverapp/driver_provider.dart';
import 'package:provider/provider.dart';

class DriverAppDrawer extends StatefulWidget {
  const DriverAppDrawer({super.key});

  @override
  State<DriverAppDrawer> createState() => _DriverAppDrawerState();
}

class _DriverAppDrawerState extends State<DriverAppDrawer> {
  void _confirmLogout() {
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
                final driverProvider = Provider.of<DriverProvider>(context, listen: false);
                driverProvider.clearUser();
                Navigator.pushReplacementNamed(context, '/login');
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
    final driverProvider = Provider.of<DriverProvider>(context, listen: false);
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[600],
            ),
            accountName: const Text('Current User'),
            accountEmail: Text(driverProvider.driver.email),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 40.0,
                color: Colors.blue,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () => Navigator.pushNamed(context, '/home'),
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.add ),
            title: const Text('Post Trip'),
            onTap: () => Navigator.pushNamed(context, '/post'),
          ),
          ListTile(
            leading: const Icon(Icons.notifications_active_outlined),
            title: const Text('Notifications'),
            onTap: () => Navigator.pushNamed(context, '/notification'),
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.calendar_today),
            title: const Text('Booked Trips'),
            onTap: () => Navigator.pushNamed(context, '/booked'),
          ),ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Trip History'),
            onTap: () => Navigator.pushNamed(context, '/history'),
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout',style: TextStyle(fontSize: 17, color: Colors.black),),
            onTap: _confirmLogout,
          ),
        ],
      ),
    );
  }
}
