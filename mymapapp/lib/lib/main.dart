import 'package:flutter/material.dart';
import 'package:mymapapp/chat.dart';
import 'package:mymapapp/homepage.dart';
import 'package:mymapapp/notifications.dart';
import 'package:mymapapp/provider.dart';
import 'package:mymapapp/register_screen.dart';
import 'package:mymapapp/search_trip.dart';
import 'package:provider/provider.dart';
import 'cancelled_completed_trips.dart';
import 'log_screen.dart';
import 'booked_trips.dart';

void main() {
  runApp(
     ChangeNotifierProvider(
         create: (context) => UserProvider(),
         child: MaterialApp(
           debugShowCheckedModeBanner: false,
           initialRoute: '/login',
           routes: {
             '/login' : (context) => LoginScreen(),
             '/register' : (context) => RegisterScreen(),
             '/home' : (context) => const HomePage(),
             '/search'  :(context) => const SelectTravelDaysScreen(),
             '/booked'  :(context) => const BookedTrips(),
             '/history' :(context) => const CancelledCompletedTrips(),
             '/notification' :(context) => NotificationsScreen(),
             '/chat' :(context) => const ChatScreen(driverName: '',driver_id: 0,passenger_id: 0,),
           },
         ),
     ),
  );
}
  @override
  Widget build(BuildContext context) {
    return  const Text('');
  }
