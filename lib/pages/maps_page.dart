import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  bool _isOnline = false;
  bool _isLoading = true;
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      try {
        final result = await InternetAddress.lookup('tile.openstreetmap.org');
        setState(() => _isOnline = result.isNotEmpty);
      } catch (_) {
        setState(() => _isOnline = false);
      }
    } else {
      setState(() => _isOnline = false);
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(_isOnline ? Icons.wifi : Icons.wifi_off),
        onPressed: _checkConnectivity,
      ),
      body: _isOnline
          ? FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(10.7202, 122.5621),
          zoom: 12.0,
          minZoom: 10.0,
          maxZoom: 16.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
        ],
      )
          : const Center(
        child: Text(
          'Offline: Map tiles cannot be loaded.\nPlease connect to the internet.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
