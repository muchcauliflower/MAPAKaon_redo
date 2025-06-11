import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';


class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late final MapController _mapController;
  List<LatLng> _routePoints = [];

  static const _apiKey = '5b3ce3597851110001cf624890ba4a979c437083c56f01de8ce2eda60ad65a23dabfcf48f2cec3bd'; // Replace with your ORS API key

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _fetchRoute();
  }

  Future<void> _fetchRoute() async {
    final coordinates = [
      [122.5621, 10.7202], // Point 1
      [122.5621, 10.7350], // Point 2
      [122.5621, 10.7400], // Point 3
    ];

    final url = Uri.parse('https://api.openrouteservice.org/v2/directions/driving-car/json');

    final body = {
      "coordinates": coordinates,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': _apiKey,
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final geometry = data['routes'][0]['geometry'];
        final distance = data['routes'][0]['summary']['distance'];

        // Print each point
        for (int i = 0; i < coordinates.length; i++) {
          final point = coordinates[i];
          debugPrint('Point ${i + 1}: Lat = ${point[1]}, Lng = ${point[0]}');
        }

        debugPrint('Total route distance: ${distance.toStringAsFixed(2)} meters');

        // Decode polyline
        PolylinePoints polylinePoints = PolylinePoints();
        List<PointLatLng> decodedPoints = polylinePoints.decodePolyline(geometry);

        final polyline = decodedPoints
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();

        setState(() {
          _routePoints = polyline;
        });
      } else {
        debugPrint('Routing failed: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error fetching route: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: const MapOptions(
          center: LatLng(10.7202, 122.5621),
          zoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: _routePoints,
                strokeWidth: 5.0,
                color: Colors.blue,
              ),
            ],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: const LatLng(10.7202, 122.5621),
                width: 40,
                height: 40,
                child: const Icon(Icons.location_on, color: Colors.red),
              ),
              Marker(
                point: const LatLng(10.7350, 122.5621),
                width: 40,
                height: 40,
                child: const Icon(Icons.flag, color: Colors.green),
              ),
              Marker(
                point: const LatLng(10.7400, 122.5621),
                width: 40,
                height: 40,
                child: const Icon(Icons.alarm, color: Colors.pinkAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
