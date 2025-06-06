import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  bool _isOnline = false;
  bool _isLoading = true;
  bool _assetsReady = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _checkConnectivity();
    await _verifyAssets();
    setState(() => _isLoading = false);
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    bool onlineStatus = false;

    if (connectivityResult != ConnectivityResult.none) {
      try {
        final result = await InternetAddress.lookup('tile.openstreetmap.org');
        onlineStatus = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } catch (_) {
        onlineStatus = false;
      }
    }

    setState(() => _isOnline = onlineStatus);
  }

  Future<void> _verifyAssets() async {
    try {
      await rootBundle.load('assets/map/tiles/0/0/0.png');
      setState(() => _assetsReady = true);
    } catch (e) {
      debugPrint('Asset verification failed: $e');
    }
  }

  Future<void> _refreshConnection() async {
    setState(() => _isLoading = true);
    await _checkConnectivity();
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isOnline ? 'Online: Using OpenStreetMap' : 'Offline: Using local tiles'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(_isOnline ? Icons.wifi : Icons.wifi_off),
        onPressed: _refreshConnection,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
        options: MapOptions(
          center: LatLng(10.7202, 122.5621),
          zoom: 13.0,
        ),
        children: [
          _buildTileLayer(),
        ],
      ),
    );
  }

  TileLayer _buildTileLayer() {
    return TileLayer(
      tileProvider: _isOnline ? NetworkTileProvider() : AssetTileProvider(),
      urlTemplate: _isOnline
          ? 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
          : 'assets/map/tiles/{z}/{x}/{y}.png',
      subdomains: _isOnline ? ['a', 'b', 'c'] : const [],
      maxNativeZoom: _isOnline ? 19 : 14,
      minNativeZoom: 0,
      backgroundColor: Colors.grey[200],
      userAgentPackageName: _isOnline ? 'com.example.app' : '',
    );
  }
}