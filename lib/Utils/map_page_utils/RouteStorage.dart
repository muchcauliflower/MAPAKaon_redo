// --- save_route.dart ---
import 'package:latlong2/latlong.dart';

class StoredRoute {
  final String routeName;
  final List<LatLng> coordinates;

  StoredRoute({required this.routeName, required this.coordinates});

  Map<String, dynamic> toJson() => {
    'routeName': routeName,
    'coordinates': coordinates
        .map((latlng) => {'lat': latlng.latitude, 'lng': latlng.longitude})
        .toList(),
  };

  factory StoredRoute.fromJson(Map<String, dynamic> json) => StoredRoute(
    routeName: json['routeName'],
    coordinates: (json['coordinates'] as List)
        .map((point) => LatLng(point['lat'], point['lng']))
        .toList(),
  );
}

List<StoredRoute> storedRoutes = []; // global temporary list