
import 'package:driverapp/driver_provider.dart';
import 'package:driverapp/post_trip_screen.dart';
import 'package:driverapp/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat.dart';
import 'completed_trips.dart';
import 'homepage.dart';
import 'log_in_screen.dart';
import 'my_trips_screen.dart';
import 'notifications.dart';
import 'register_car_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DriverProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
               routes: {
          '/login' : (context) => const LoginScreen(),
          '/register' : (context) => const RegisterPage(),
          '/registercar' : (context) => const RegisterCarForm(),
          '/home' : (context) => const HomePage(),
          '/post' : (context) => const PostTrip(),
          '/booked'  :(context) => const MyTrips(),
          '/history' :(context) => const MyCompletedTrips(),
          '/notification' :(context) => NotificationsScreen(),
          '/chat' :(context) => const ChatScreen(passengerName: '', driver_id: 0,passenger_id: 0,),
        },
      ),
    ),

  );
}

  @override
  Widget build(BuildContext context) {
    return const Text('');
  }

