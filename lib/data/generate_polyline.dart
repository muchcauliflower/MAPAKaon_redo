import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:latlong2/latlong.dart';

const String apiKey = '5b3ce3597851110001cf624890ba4a979c437083c56f01de8ce2eda60ad65a23dabfcf48f2cec3bd'; // Replace with your ORS key

// Replace this with your real input route
final List<LatLng> routePoints = [
  LatLng(10.69221330039271, 122.5734456466636),
  LatLng(10.692040385124916, 122.56944026027995),
  LatLng(10.69299887927884, 122.56903766787673),
  LatLng(10.6962738265086, 122.56906878572907),
  LatLng(10.696379489265837, 122.56837871597456),
  LatLng(10.693473205565523, 122.55902006899125),
  LatLng(10.694195183437836, 122.55558102367023),
  LatLng(10.69359722909442, 122.55512879182479),
  LatLng(10.692301311773985, 122.55174736958365),
  LatLng(10.692045557948274, 122.54850737084955),
  LatLng(10.693428962315254, 122.54664392413058),
  LatLng(10.695741406612568, 122.54460854551142),
  LatLng(10.696532165462083, 122.54527274288684),
];

Future<void> main() async {
  final List<LatLng> fullPolyline = [];

  for (int i = 0; i < routePoints.length - 1; i++) {
    final start = routePoints[i];
    final end = routePoints[i + 1];

    final segment = await fetchSegment(start, end);
    if (segment != null) {
      fullPolyline.addAll(segment);
    }

    await Future.delayed(Duration(milliseconds: 600)); // ORS rate limit
  }

  print('\n{\n  "routeName": "Route # 25 (BALUARTE DERECHO) Molo – Iloilo City Proper via General Luna (Plaza Libtertad, Zamora Str to Escoto Natividad Building)",');
  print('  "coordinates": [');

  for (int i = 0; i < fullPolyline.length; i++) {
    final point = fullPolyline[i];
    final comma = i == fullPolyline.length - 1 ? '' : ',';
    print('    {"latitude": ${point.latitude}, "longitude": ${point.longitude}}$comma');
  }

  print('  ]\n}');
}

Future<List<LatLng>?> fetchSegment(LatLng start, LatLng end) async {
  final url = Uri.parse('https://api.openrouteservice.org/v2/directions/driving-car/json');

  final body = jsonEncode({
    "coordinates": [
      [start.longitude, start.latitude],
      [end.longitude, end.latitude]
    ],
  });

  try {
    final response = await http.post(
      url,
      headers: {
        'Authorization': apiKey,
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final encoded = data['routes'][0]['geometry'];
      final polylinePoints = PolylinePoints().decodePolyline(encoded);

      return polylinePoints
          .map((e) => LatLng(e.latitude, e.longitude))
          .toList();
    } else {
      print('Failed to fetch segment: ${response.body}');
      return null;
    }
  } catch (e) {
    print('Error fetching segment: $e');
    return null;
  }
}
