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
  late Future<bool> _isOnline;

  @override
  void initState(){
    super.initState();
    _isOnline = _checkConnectivity();
  }

  Future<bool> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    // Pinging OpenStreetMap
    try {
      final result = await InternetAddress.lookup('tile.openstreetmap.org');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FutureBuilder<bool>(
        future: _isOnline,
        builder: (context, snapshot){
          return FloatingActionButton(
            child: Icon(snapshot.data == true ? Icons.wifi : Icons.wifi_off),
            // onPressed: () => setState((){
            //   _isOnline = _checkConnectivity();
            // }),
            onPressed: () async{
              final newStatus = await _checkConnectivity();
              setState(() {
                _isOnline = Future.value(newStatus);
              });

              final message = newStatus ? 'Online U faggot' : "Offline U Gaylord";
              final messageColor = newStatus ? Colors.black38 : Colors.black54;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: messageColor,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 2),
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              );
            },
          );
        }
      ),
      body: FutureBuilder(
          future: _isOnline,
          builder: (context, snapshot){
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            final isOnline = snapshot.data ?? false;
            return FlutterMap(
                options: MapOptions(
                  center: LatLng(10.7202, 122.5621),
                  zoom: 13.0
                ),
                children: [
                  _buildTileLayer(isOnline),
                ]
            );
          },
      ),
    );
  }
}

TileLayer _buildTileLayer(bool isOnline) {
  return TileLayer(
    tileProvider: isOnline ? NetworkTileProvider() : AssetTileProvider(),
    urlTemplate: isOnline
        ? 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
        : 'assets/panay_tiles/{z}/{x}/{y}.png',
    subdomains: isOnline ? ['a', 'b', 'c'] : const [],
    maxNativeZoom: isOnline ? 19 : 14,
    minNativeZoom: 0,
    userAgentPackageName: isOnline ? 'com.example.app' : '',
    fallbackUrl: isOnline ? null : 'assets/panay_tiles/0/0/0.png',
  );
}