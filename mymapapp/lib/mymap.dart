import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class RouteMap extends StatefulWidget {
  const RouteMap({super.key});
  @override
  State<RouteMap> createState() => _RouteMapState();
}

final List<String> options = ['option 1', 'option 2'];
class _RouteMapState extends State<RouteMap> {
  final MapController _mapController = MapController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  List<LatLng> routePoints = [];
  LatLng? _startPoint;

  String currentoption  = options[0];
  LatLng? _endPoint;
  
  Future<LatLng> geoCoordinates(String address) async{
    final response = await http.get(Uri.parse(''));
    final data = json.decode(response.body);
    
    if(data != null){
      final result = data[0];
      return LatLng(double.parse(result['lat']), double.parse(result['lon']));
    }
    else{
      throw Exception('Address does not exist');
    }
  }
  Future<void> calculateRoute() async {
    final startController = _startController.text;
    final endController = _endController.text;

    if(startController.isEmpty && endController.isEmpty){
      print('Please enter both start and end location');
      return;
    }

    try{
      _startPoint =  await geoCoordinates(startController);
      _endPoint = await geoCoordinates(endController);

      final response = await http.post(
        Uri.parse(''),
        headers: {
          'Authorazation' : '',
          'Content-Type' : 'application/json',
        },
        body: json.encode({
          'coordinates' : [[_startPoint?.longitude,_startPoint?.latitude],[_endPoint?.longitude,_endPoint?.latitude]]
        })
      );

      final data = json.decode(response.body);

      if(data['features'] != null && data['features'].isNotEmpty){
        final routeCoordinates = data['features'][0]['geometry']['coordinates'].toList();
        setState(() {
          routePoints = routeCoordinates.map<LatLng>((coord) => LatLng(coord[1], coord[0]));
          _mapController.fitCamera(CameraFit.bounds(bounds: LatLngBounds.fromPoints(routePoints)));
        });
      }
    }
    catch(e){
      throw Exception(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter start location',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                ElevatedButton(
                    onPressed: calculateRoute, 
                    child: Text(
                      'Get Route',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0,
                      ),
                    )
                )
              ],
            ),
          ),
          Expanded(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: LatLng(-26.1976, 28.0016),
                  initialZoom: 10.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:'https://openstreetmap.org/{z}/{x}/{y}'
                  ),

                  if(_startPoint != null && _endPoint != null)

                    MarkerLayer(
                        markers: [
                          Marker(
                              point: _startPoint!,
                              child: Icon(
                                Icons.location_on,

                          )
                          ),
                        ]
                    ),

                ],
              )
          ),
          ListTile(
            leading: Radio(
              value: options[0],
              groupValue: currentoption,
              onChanged: (value){
                setState(() {
                  currentoption = value.toString();
                });
              }

            )


          )
        ],

      ),
    );
  }
}
