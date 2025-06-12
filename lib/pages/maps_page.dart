import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../Utils/map_page_utils/RouteStorage.dart';
import '../Utils/map_page_utils/map_page_widgets.dart';
import '../Utils/map_page_utils/route_picker_dialog.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late final MapController _mapController;
  List<List<LatLng>> _routeSegments = [];
  List<LatLng> clickedPoints = [];
  bool isAddingMarkers = false;

  static const _apiKey = '5b3ce3597851110001cf624890ba4a979c437083c56f01de8ce2eda60ad65a23dabfcf48f2cec3bd'; // Replace with your real OpenRouteService API key

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  void _saveCurrentRoute(String name) {
    if (clickedPoints.isEmpty) return;

    final newRoute = StoredRoute(
      routeName: name,
      coordinates: List<LatLng>.from(clickedPoints),
    );

    setState(() {
      storedRoutes.add(newRoute);
      clickedPoints.clear();
      _routeSegments.clear();
    });

    debugPrint('Saved route "$name" with ${newRoute.coordinates.length} points.');
  }

  Future<void> _fetchRouteSegments() async {
    if (clickedPoints.length < 2) return;

    List<List<LatLng>> segments = [];

    for (int i = 0; i < clickedPoints.length - 1; i++) {
      final start = clickedPoints[i];
      final end = clickedPoints[i + 1];

      final url = Uri.parse('https://api.openrouteservice.org/v2/directions/driving-car/json');
      final body = {
        "coordinates": [
          [start.longitude, start.latitude],
          [end.longitude, end.latitude]
        ],
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

          PolylinePoints polylinePoints = PolylinePoints();
          List<PointLatLng> decodedPoints = polylinePoints.decodePolyline(geometry);

          final polyline = decodedPoints
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();

          segments.add(polyline);
        } else {
          debugPrint('Routing failed for segment $i: ${response.body}');
        }
      } catch (e) {
        debugPrint('Error fetching segment $i: $e');
      }
    }

    setState(() {
      _routeSegments = segments;
    });
  }

  void _handleMapTap(LatLng point) {
    if (!isAddingMarkers) return;

    setState(() {
      clickedPoints.add(point);
    });

    _fetchRouteSegments();

    debugPrint('Stored clicked points:');
    for (final p in clickedPoints) {
      debugPrint('Lat: ${p.latitude}, Lng: ${p.longitude}');
    }
  }

  void _toggleAddingMarkers() {
    setState(() {
      isAddingMarkers = !isAddingMarkers;
    });
  }

  void _clearAll() {
    setState(() {
      clickedPoints.clear();
      _routeSegments.clear();
    });
  }

  void _showRoutePicker() async {
    final selectedRoute = await showDialog(
      context: context,
      builder: (context) => const RoutePickerDialog(),
    );

    if (selectedRoute != null) {
      setState(() {
        clickedPoints = List<LatLng>.from(selectedRoute.coordinates);
      });
      _fetchRouteSegments();
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildMapAppBar(
        context: context,
        isAddingMarkers: isAddingMarkers,
        onToggleAdd: _toggleAddingMarkers,
        onClear: _clearAll,
        onSaveRoute: _saveCurrentRoute,
        onOpenRoutes: _showRoutePicker,
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(10.7202, 122.5621),
          zoom: 17.0,
          onTap: (tapPosition, latlng) => _handleMapTap(latlng),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          PolylineLayer(
            polylines: List.generate(
              _routeSegments.length,
                  (index) => Polyline(
                points: _routeSegments[index],
                strokeWidth: 5.0,
                color: Colors.blueAccent,
              ),
            ),
          ),
          MarkerLayer(
            markers: clickedPoints.map((point) {
              return Marker(
                point: point,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
