import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

// Class for the storedlocations
class storedLocations {
  final List nodeLocation;
  final Color nodeColor;
  final IconData nodeIcon;
  final bool drawRoute; //flag on whether to draw the route or not

  storedLocations({
    required this.nodeLocation,
    required this.nodeColor,
    required this.nodeIcon,
    required this.drawRoute
  });
}

// This must be outside any class so it can be imported
final List<Color> segmentColors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.purple,
  Colors.yellow,
];

// sample data for when a person wants to go from MT to SM city
// will add all types where person is required to walk, take jeep, switch jeeps
// so location 1: MT lobby
// Location 2: waiting shed outside cpu
// Location 3: jaro Plaza
// Location 4: SM city
// Location 5: walking to kenny Rogers
final List<storedLocations> sampleStoredLocations = [
  storedLocations(nodeLocation: [10.732768, 122.548177], nodeColor: Colors.pinkAccent, nodeIcon: Icons.start, drawRoute: true), //start area walking to second point
  storedLocations(nodeLocation: [10.733382, 122.549060], nodeColor: Colors.yellow, nodeIcon: Icons.directions_bus, drawRoute: true), // this area takes the transport
  storedLocations(nodeLocation: [10.725513, 122.557004], nodeColor: Colors.greenAccent, nodeIcon: Icons.directions_bus, drawRoute: true), // switches transport
  storedLocations(nodeLocation: [10.713912, 122.552066], nodeColor: Colors.blueAccent, nodeIcon: Icons.local_mall, drawRoute: true), // go closest
  storedLocations(nodeLocation: [10.714162, 122.551581], nodeColor: Colors.redAccent, nodeIcon: Icons.location_on, drawRoute: false) // walks to destination
];