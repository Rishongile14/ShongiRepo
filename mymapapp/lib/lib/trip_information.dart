import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RouteApp(),
    );
  }
}

class RouteApp extends StatefulWidget {
  @override
  _RouteAppState createState() => _RouteAppState();
}

class _RouteAppState extends State<RouteApp> {
  final MapController _mapController = MapController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  List<LatLng> _routePoints = [];
  LatLng? _startPoint;
  LatLng? _endPoint;

  Future<List<String>> _getLocationSuggestions(String query) async {
    final response = await http.get(Uri.parse('https://nominatim.openstreetmap.org/search?format=json&q=${Uri.encodeComponent(query)}'));
    final data = json.decode(response.body);

    return data.map<String>((result) => result['display_name']).toList();
  }

  Future<LatLng> _geocodeAddress(String address) async {
    final response = await http.get(Uri.parse('https://nominatim.openstreetmap.org/search?format=json&q=${Uri.encodeComponent(address)}'));
    final data = json.decode(response.body);

    if (data.isNotEmpty) {
      final result = data[0];
      return LatLng(double.parse(result['lat']), double.parse(result['lon']));
    } else {
      throw Exception('Location not found: $address');
    }
  }

  Future<void> _calculateRoute() async {
    final startAddress = _startController.text;
    final endAddress = _endController.text;

    if (startAddress.isEmpty || endAddress.isEmpty) {
      _showAlert('Please enter both start and end locations');
      return;
    }

    try {
      _startPoint = await _geocodeAddress(startAddress);
      _endPoint = await _geocodeAddress(endAddress);

      final response = await http.post(
        Uri.parse('https://api.openrouteservice.org/v2/directions/driving-car/geojson'),
        headers: {
          'Authorization': '5b3ce3597851110001cf6248ba03658a4a6c4473bd77801d87c80532',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'coordinates': [
            [_startPoint?.longitude, _startPoint?.latitude],
            [_endPoint?.longitude, _endPoint?.latitude],
          ],
        }),
      );

      final data = json.decode(response.body);

      if (data['features'] != null && data['features'].isNotEmpty) {
        final routeCoordinates = data['features'][0]['geometry']['coordinates'];
        setState(() {
          _routePoints = routeCoordinates.map<LatLng>((coord) => LatLng(coord[1], coord[0])).toList();
          _mapController.fitCamera(CameraFit.bounds(bounds: LatLngBounds.fromPoints(_routePoints)));
        });
      } else {
        _showAlert('No route found');
      }
    } catch (e) {
      _showAlert('Error: $e');
    }
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route with OSM, ORS, and Location Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child:
                  TypeAheadField(
                     controller: _startController,

                    suggestionsCallback: (pattern) async {
                      return await _getLocationSuggestions(pattern);
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSelected: (suggestion) {
                      _startController.text = suggestion;
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TypeAheadField(
                     controller: _endController,
                    suggestionsCallback: (pattern) async {
                      return await _getLocationSuggestions(pattern);
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSelected: (suggestion) {
                      _endController.text = suggestion;
                    },
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _calculateRoute,
                  child: Text('Get Route'),
                ),
              ],
            ),
          ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(

                  initialCenter: LatLng(-26.1926, 28.0016),
                initialZoom: 10,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                if (_startPoint != null && _endPoint != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _startPoint!,
                        child: Icon(Icons.location_on, color: Colors.green, size: 40),
                      ),
                    ],
                  ),
                MarkerLayer(
                    markers: [
                      Marker(
                        point: _endPoint!,
                        child: Icon(Icons.location_on, color: Colors.red, size: 40),
                      ),
                    ],
                  ),
                if (_routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: _routePoints,
                        strokeWidth: 4,
                        color: Colors.blue,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
