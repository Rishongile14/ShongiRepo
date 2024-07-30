import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:mymapapp/provider.dart';
import 'package:mymapapp/trip_information.dart';
import 'package:provider/provider.dart';


class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen(this.tripDriverInfo, {super.key});
  final Map<String, dynamic> tripDriverInfo;
  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

List<String> options = ['Weekly', 'Monthly','Yearly'];
DateTime currentDate = DateTime.now();
double originalprice = 40;
class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String currentoption = options[0];
  DateTime startDate = currentDate;
  DateTime endDate = currentDate.add(Duration(days: 7));

   double calculatedprice = originalprice * 7;

  var current_user;  /// to keep track of current user
  var trip_selcetd;
  var id;


  Future<void> addBookedTrip() async {
    try{
      var response = await http.post(
        Uri.parse('http://10.254.97.200:5001/addbookedtrip'),
        headers:  { 'Content-Type' : 'application/json'},
        body:  json.encode({
          'driver_id' : widget.tripDriverInfo['driver_id'],
          'trip_id'  :  widget.tripDriverInfo['trip_id'],
          'passenger_id' : id,
          'vehicle_id' : widget.tripDriverInfo['vehicle_id'],
          'price' : calculatedprice,
          'bookedseats' : '1',

        })
      );
      var data = json.decode(response.body);
      print(data);
    }catch(err){
      throw err;
    }
  }


///current user object obtained during logging in
  Future<void> addSubscription(var current_user,var selected_trip, DateTime start_date,DateTime end_date,double discount, double price, int seats, bool active) async{

    try{
      var response = await http.post(
          Uri.parse('http://192.168.230.155:5001/addSubscription'),
        headers: {'Content-Type' : 'application/json'},
        body:  json.encode({
          'user_id' : current_user.user_id,
          'trip_id' :  selected_trip.trip_id,
          'start_date' : start_date,
          'end_date' : end_date,
          'seats' : seats,  /// booked
          'discount' : discount,
          'price' : price,
          'active' : false, /// this will be updated after the user has paid
        })
      );

      var data = json.decode(response.body);

    }catch(e){
      throw Exception(e);
    }


  }


  void changeDate(currentOption){
    switch(currentOption){
      case 'Weekly':
        setState(() {
          startDate = currentDate;
          endDate = currentDate.add(Duration(days: 7));
          calculatedprice = originalprice * 7;

        });
        break;
      case 'Monthly':
        setState(() {
          startDate = currentDate;
          endDate = currentDate.add(Duration(days: 30));
          calculatedprice = originalprice * 30;
        });
        break;
      case 'Yearly':
        setState(() {
          startDate = currentDate;
          endDate = currentDate.add(Duration(days: 365));
          calculatedprice = originalprice * 365;
        });
        break;
    }
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Subscription Successful"),
          content: Text(
              "You have successfully subscribed to the route/trip. We will notify you with updates and information regarding this trip. Thank you!",
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userProvider = Provider.of<UserProvider>(context);
    id = userProvider.user.id;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription',
          style: TextStyle(
            color : Colors.white,
          )
        ),
        backgroundColor:Colors.grey[600] ,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [


            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[600],
              ),
              child: Column(
                children: [
                  // Driver's profile
                  Row(
                    children: [
                      ClipOval(
                        child: Image.network(
                          'https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg',
                          height: 70,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                   '${widget.tripDriverInfo['drivername']}',
                                   style: TextStyle(
                                     fontSize: 16.0,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.white
                                   ),
                                 ),
                                 Text(
                                   'Driver',
                                   style: TextStyle(
                                     color: Colors.white,
                                   ),
                                 ),
                               ],
                             ),
                            SizedBox(height: 8.0),
                           Column(
                             children: [
                               Row(
                                 children: [
                                   Icon(CupertinoIcons.car_detailed,
                                       size: 20,
                                     color: Colors.white,
                                   ),
                                   SizedBox(width: 8.0),
                                   Text('${widget.tripDriverInfo['name']}',
                                     style: TextStyle(
                                       color: Colors.white,
                                     ),
                                   ),
                                 ],
                               ),
                               SizedBox(height: 5.0),
                               Row(
                                 children: [
                                   Icon(CupertinoIcons.person_2_alt,
                                       size: 20,
                                     color: Colors.white,
                                   ),
                                   SizedBox(width: 8.0),
                                   Text('${widget.tripDriverInfo['seats']} Passengers',
                                     style: TextStyle(
                                       color: Colors.white,
                                     ),
                                   ),
                                 ],
                               ),
                             ],
                           )
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Outbound Trip Information
                  SizedBox(height: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Outbound Trip Information',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          ClipOval(
                            child: Container(
                              color: Colors.white,
                              height: 40,
                              width: 40,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.tripDriverInfo['start_location']}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Daily, 08:00 AM',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),


                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child:
                          Container(
                            height: 40.0,
                            width: 3.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          ClipOval(
                            child: Container(
                              color: Colors.white,
                              height: 40,
                              width: 40,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.tripDriverInfo['end_location']}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Daily, 08:30 AM',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),


                        ],
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    children: [
                      Center(
                        child: Text(
                          'Return Trip Information',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          ClipOval(
                            child: Container(
                              color: Colors.white,
                              height: 40,
                              width: 40,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                            '${widget.tripDriverInfo['end_location']}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Daily, 17:00 PM',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),


                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child:
                          Container(
                            height: 40.0,
                            width: 3.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          ClipOval(
                            child: Container(
                              color: Colors.white,
                              height: 40,
                              width: 40,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.tripDriverInfo['start_location']}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Daily, 17:30 PM',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),


                        ],
                      ),
                    ],

                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                     Row(
                       children: [
                         Radio(value: options[0],
                             focusColor: Colors.white,
                             groupValue: currentoption,
                             onChanged: (value){
                               setState(() {
                                 currentoption = value.toString();
                                 changeDate(currentoption);
                               });
                             }

                         ),
                         Text('Weekly',
                           style: TextStyle(
                             color: Colors.white,
                           ),
                         )
                       ],
                     ),
                      Row(
                        children: [
                          Radio(value: options[1],
                              groupValue: currentoption,
                              onChanged: (value){
                                setState(() {
                                  currentoption = value.toString();
                                  changeDate(currentoption);
                                });
                              }
                          ),
                          Text('Monthly',
                            style: TextStyle(
                              color: Colors.white,
                            ),)
                        ],
                      ),
                      Row(
                        children: [
                          Radio(value: options[2],
                              groupValue: currentoption,
                              onChanged: (value){
                                setState(() {
                                  currentoption = value.toString();
                                  changeDate(currentoption);
                                });
                              }
                          ),
                          Text('Yearly',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.white,
                      ),
                      Text('$startDate - $endDate',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          Text('1',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      Text(
                        '$calculatedprice',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight:  FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[600],
                    ),
                     child: Text('Subscribe',
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 18.0,
                         color: Colors.white,
                       ),
                     ),
                    onPressed: (){
                      addBookedTrip();
                      _showDialog(context);

                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}