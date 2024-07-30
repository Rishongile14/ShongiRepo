import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymapapp/provider.dart';
import 'package:provider/provider.dart';

class PassengerAppDrawer extends StatefulWidget {
  const PassengerAppDrawer({super.key});

  @override
  State<PassengerAppDrawer> createState() => _PassengerAppDrawerState();
}

class _PassengerAppDrawerState extends State<PassengerAppDrawer> {
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
                final userProvider = Provider.of<UserProvider>(context, listen: false);
                userProvider.clearUser();

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                  );
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
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[600],
            ),
            accountName: const Text('Current User'),
            accountEmail: Text(userProvider.user.email),
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
            leading: const Icon(CupertinoIcons.search),
            title: const Text('Search Trip'),
            onTap: () => Navigator.pushNamed(context, '/search'),
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
          ListTile(
            leading: const Icon(Icons.chat_outlined),
            title: const Text('Chat'),
            onTap: () => Navigator.pushNamed(context, '/chat'),
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
